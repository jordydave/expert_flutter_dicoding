import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'top_rated_movie_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
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
    expect(topRatedMovieBloc.state, equals(TopRatedMovieEmpty()));
  });
  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, HasData] when Top Rated Movie is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when get Top Rated Movie is unsuccessfull.',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMovieLoading(),
      const TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
