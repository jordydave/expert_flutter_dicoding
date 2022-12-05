import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_genre_list.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_list_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_genre_list_test.mocks.dart';

@GenerateMocks([GetTVGenreList])
void main() {
  late TvGenreListBloc tvGenreListBloc;
  late MockGetTVGenreList mockGetTVGenreList;

  setUp(() {
    mockGetTVGenreList = MockGetTVGenreList();
    tvGenreListBloc = TvGenreListBloc(mockGetTVGenreList);
  });

  final tTVModel = testTv;
  const tId = 1;
  final tTVList = <TV>[tTVModel];

  test('initial state should be empty', () {
    expect(tvGenreListBloc.state, equals(TvGenreListEmpty()));
  });

  blocTest<TvGenreListBloc, TvGenreListState>(
    'Should emit [Loading, HasData] when TV Genre is gotten successfully',
    build: () {
      when(mockGetTVGenreList.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      return tvGenreListBloc;
    },
    act: (bloc) => bloc.add(GetTvGenreList(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvGenreListLoading(),
      TvGenreListHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTVGenreList.execute(tId));
    },
  );

  blocTest<TvGenreListBloc, TvGenreListState>(
    'Should emit [Loading, Error] when TV Genre is gotten unsuccessfully',
    build: () {
      when(mockGetTVGenreList.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvGenreListBloc;
    },
    act: (bloc) => bloc.add(GetTvGenreList(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvGenreListLoading(),
      TvGenreListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVGenreList.execute(tId));
    },
  );
}
