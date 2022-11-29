import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTV, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTV mockGetWatchlistTV;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvWatchlistBloc = TvWatchlistBloc(
      mockGetWatchlistTV,
      mockGetWatchlistStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  test('initial state must be Initial state', () {
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  group('testing watchlist tv', () {
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

    final tTvList = [tTVModel];

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, HasData] when get list of watchlist tv successfully',
      build: () {
        when(mockGetWatchlistTV.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetTvWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistHasData(tTvList),
      ],
      verify: (bloc) => verify(mockGetWatchlistTV.execute()),
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get data list of watchlist tv unsuccessfully',
      build: () {
        when(mockGetWatchlistTV.execute()).thenAnswer(
            (_) async => const Left(ServerFailure(('Server Failure'))));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetTvWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        const TvWatchlistError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetWatchlistTV.execute()),
    );
  });
}
