import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_genre_list.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_list_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_genre_list_test.mocks.dart';

@GenerateMocks([GetMoviesGenreList])
void main() {
  late MovieGenreListBloc movieGenreListBloc;
  late MockGetMoviesGenreList mockGetMoviesGenreList;

  setUp(() {
    mockGetMoviesGenreList = MockGetMoviesGenreList();
    movieGenreListBloc = MovieGenreListBloc(mockGetMoviesGenreList);
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
  const tId = 1;
  final tMovieList = <Movie>[tMovieModel];

  test('initial state should be empty', () {
    expect(movieGenreListBloc.state, equals(MovieGenreListEmpty()));
  });

  blocTest<MovieGenreListBloc, MovieGenreListState>(
    'Should emit [Loading, HasData] when List Movie Genre is gotten successfully',
    build: () {
      when(mockGetMoviesGenreList.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return movieGenreListBloc;
    },
    act: (bloc) => bloc.add(const GetMovieGenreList(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieGenreListLoading(),
      MovieGenreListHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMoviesGenreList.execute(tId));
    },
  );

  blocTest<MovieGenreListBloc, MovieGenreListState>(
    'Should emit [Loading, Error] when List Movie Genre is gotten unsuccessfully',
    build: () {
      when(mockGetMoviesGenreList.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieGenreListBloc;
    },
    act: (bloc) => bloc.add(const GetMovieGenreList(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieGenreListLoading(),
      const MovieGenreListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMoviesGenreList.execute(tId));
    },
  );
}
