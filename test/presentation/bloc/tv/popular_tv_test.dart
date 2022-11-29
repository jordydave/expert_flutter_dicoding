import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_tv_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTV mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTV();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
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
    expect(popularTvBloc.state, equals(PopularTvEmpty()));
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when Popular TV is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTVList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetPopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when Popular TV is gotten unsuccessfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetPopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvLoading(),
      const PopularTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
