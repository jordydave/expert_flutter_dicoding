import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_test.mocks.dart';

@GenerateMocks([GetNowPlayingTV])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTV mockGetNowPlayingTV;

  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTV();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTV);
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
    expect(nowPlayingTvBloc.state, equals(NowPlayingTvEmpty()));
  });
  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, HasData] when Now Playing TV is gotten successfully',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );
  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, Error] when Now Playing TV is gotten unsuccessfully',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingTvLoading(),
      const NowPlayingTvError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );
}
