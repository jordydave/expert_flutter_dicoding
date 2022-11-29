import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:ditonton/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTV(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTV(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTV(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTV(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
  group('Get TV Detail By Id', () {
    const tId = 1;

    test('should return TV Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTVById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVById(tId);
      // assert
      expect(result, null);
    });
  });
  group('get watchlist tv', () {
    test('should return list of TVTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTV())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTV();
      // assert
      expect(result, [testTvTable]);
    });
  });
  group('cache now playing tv', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTV('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingTV([testTvCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheTV('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTV([testTvCache], 'now playing'));
    });

    test('should return list of tv from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTV('now playing'))
          .thenAnswer((_) async => [testTVCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingTV();
      // assert
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTV('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingTV();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
