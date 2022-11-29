import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTV mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTV();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  final tTVModel = TV(
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    firstAirDate: "2011-04-17",
    genreIds: const [10765, 10759, 18],
    id: 1399,
    name: "Game of Thrones",
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    voteAverage: 7.91,
    voteCount: 1172,
  );
  final tTVList = <TV>[tTVModel];

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, equals(TopRatedTvEmpty()));
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when Top Rated TV is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTVList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when Top Rated TV is gotten unsuccessfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
