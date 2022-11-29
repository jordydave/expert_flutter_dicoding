import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_movie_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  final tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];

  test('initial state should be empty', () {
    expect(popularMovieBloc.state, equals(PopularMovieEmpty()));
  });
  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when Popular Movie is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetPopularMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when get Popular Movie is unsuccessfull.',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetPopularMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMovieLoading(),
      const PopularMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
