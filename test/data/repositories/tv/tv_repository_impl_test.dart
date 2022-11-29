import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/repositories/tv/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/utils/exception.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tTvModel = TVModel(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    firstAirDate: '2010-06-08',
    genreIds: [18, 9648],
    id: 31917,
    name: 'Pretty Little Liars',
    originalLanguage: 'en',
    originalName: 'Pretty Little Liars',
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    voteAverage: 5.04,
    voteCount: 133,
  );

  final tTv = TV(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    firstAirDate: '2010-06-08',
    genreIds: const [18, 9648],
    id: 31917,
    name: 'Pretty Little Liars',
    originalLanguage: 'en',
    originalName: 'Pretty Little Liars',
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    voteAverage: 5.04,
    voteCount: 133,
  );

  final tTvModelList = <TVModel>[tTvModel];
  final tTvList = <TV>[tTv];

  group('Now Playing TV', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingTV()).thenAnswer((_) async => []);
      // act
      await repository.getNowPlayingTV();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });
      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        verify(mockLocalDataSource.cacheNowPlayingTV([testTvCache]));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTV())
            .thenAnswer((_) async => [testTvCache]);
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTV());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTV())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTV());
        expect(result, const Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular TV', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });
    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });
    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Detail', () {
    const tId = 1;
    const tTvResponse = TVDetailResponse(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'homepage',
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      status: 'status',
      type: 'type',
      voteAverage: 1.0,
      voteCount: 1,
      tagline: 'tagline',
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Right(testTVDetail)));
    });
    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTvList = <TVModel>[];
    const tId = 1;
    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });
    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV', () {
    const tQuery = 'pretty little liars';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });
    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TV', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}
