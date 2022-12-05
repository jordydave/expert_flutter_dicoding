import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_genre.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_genre_test.mocks.dart';

@GenerateMocks([GetMoviesGenre])
void main() {
  late MovieGenreBloc movieGenreBloc;
  late MockGetMoviesGenre mockGetMoviesGenre;

  setUp(() {
    mockGetMoviesGenre = MockGetMoviesGenre();
    movieGenreBloc = MovieGenreBloc(mockGetMoviesGenre);
  });

  final tGenreModel = Genre(
    id: 28,
    name: "Action",
  );

  final tGenreList = <Genre>[tGenreModel];

  test('initial state should be empty', () {
    expect(movieGenreBloc.state, equals(MovieGenreEmpty()));
  });

  blocTest<MovieGenreBloc, MovieGenreState>(
    'Should emit [Loading, HasData] when Movie Genre is gotten successfully',
    build: () {
      when(mockGetMoviesGenre.execute())
          .thenAnswer((_) async => Right(tGenreList));
      return movieGenreBloc;
    },
    act: (bloc) => bloc.add(GetMovieGenre()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieGenreLoading(),
      MovieGenreHasData(tGenreList),
    ],
    verify: (bloc) {
      verify(mockGetMoviesGenre.execute());
    },
  );

  blocTest<MovieGenreBloc, MovieGenreState>(
    'Should emit [Loading, Error] when Movie Genre is gotten unsuccessfully',
    build: () {
      when(mockGetMoviesGenre.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieGenreBloc;
    },
    act: (bloc) => bloc.add(GetMovieGenre()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieGenreLoading(),
      MovieGenreError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMoviesGenre.execute());
    },
  );
}
