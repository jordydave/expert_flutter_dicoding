import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_genre.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_genre_test.mocks.dart';

@GenerateMocks([GetTVGenre])
void main() {
  late TvGenreBloc tvGenreBloc;
  late MockGetTVGenre mockGetTVGenre;

  setUp(() {
    mockGetTVGenre = MockGetTVGenre();
    tvGenreBloc = TvGenreBloc(mockGetTVGenre);
  });

  final tGenreModel = Genre(
    id: 10759,
    name: "Action & Adventure",
  );

  final tGenreList = <Genre>[tGenreModel];

  test('initial state should be empty', () {
    expect(tvGenreBloc.state, equals(TvGenreEmpty()));
  });

  blocTest<TvGenreBloc, TvGenreState>(
    'Should emit [Loading, HasData] when TV Genre is gotten successfully',
    build: () {
      when(mockGetTVGenre.execute()).thenAnswer((_) async => Right(tGenreList));
      return tvGenreBloc;
    },
    act: (bloc) => bloc.add(GetTvGenre()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvGenreLoading(),
      TvGenreHasData(tGenreList),
    ],
    verify: (bloc) {
      verify(mockGetTVGenre.execute());
    },
  );

  blocTest<TvGenreBloc, TvGenreState>(
    'Should emit [Loading, Error] when TV Genre is gotten unsuccessfully',
    build: () {
      when(mockGetTVGenre.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvGenreBloc;
    },
    act: (bloc) => bloc.add(GetTvGenre()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvGenreLoading(),
      TvGenreError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVGenre.execute());
    },
  );
}
