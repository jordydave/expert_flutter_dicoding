import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_similar.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_video.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks(
    [GetMovieDetail, GetMovieRecommendations, GetMovieSimilar, GetMoviesVideos])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieSimilar mockGetMovieSimilar;
  late MockGetMoviesVideos mockGetMoviesVideos;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetMovieSimilar = MockGetMovieSimilar();
    mockGetMoviesVideos = MockGetMoviesVideos();

    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetMovieSimilar,
      mockGetMoviesVideos,
    );
  });

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = [tMovie];

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, equals(MovieDetailEmpty()));
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when Detail Movie is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => const Right(tMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetMovieSimilar.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetMoviesVideos.execute(1))
          .thenAnswer((_) async => Right(tListMovieVideo));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(
        tMovieDetail,
        tMovieList,
        tMovieList,
        tListMovieVideo,
      ),
    ],
    verify: (bloc) {
      verify(
        mockGetMovieDetail.execute(1),
      );
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get Detail Movie unsuccessfully ',
    build: () {
      when(mockGetMovieDetail.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      when(mockGetMovieRecommendations.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      when(mockGetMovieSimilar.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      when(mockGetMoviesVideos.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetails(1)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetMovieDetail.execute(1)),
  );
}
