import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_reccomendations.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_similar.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_test.mocks.dart';

@GenerateMocks([GetTVDetail, GetTVRecommendations, GetTVSimilar])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetTVSimilar mockGetTVSimilar;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetTVSimilar = MockGetTVSimilar();
    tvDetailBloc = TvDetailBloc(
      mockGetTVDetail,
      mockGetTVRecommendations,
      mockGetTVSimilar,
    );
  });

  const tTVDetail = TVDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
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
    expect(tvDetailBloc.state, equals(TvDetailEmpty()));
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when Detail TV is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(1))
          .thenAnswer((_) async => const Right(tTVDetail));
      when(mockGetTVRecommendations.execute(1))
          .thenAnswer((_) async => Right(tTVList));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const GetTVDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(
        tTVDetail,
        tTVList,
        tTVList,
      ),
    ],
    verify: (bloc) {
      verify(
        mockGetTVDetail.execute(1),
      );
    },
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get Detail TV unsuccessfully ',
    build: () {
      when(mockGetTVDetail.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      when(mockGetTVRecommendations.execute(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const GetTVDetails(1)),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTVDetail.execute(1)),
  );
}
