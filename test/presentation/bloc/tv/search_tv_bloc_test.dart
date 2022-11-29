
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchTvBloc = SearchTvBloc(mockSearchTV);
  });

  final tTVModel = TV(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    originalLanguage: 'en',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTVList = <TV>[tTVModel];
  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchTvBloc.state, equals(SearchTvEmpty()));
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessfull.',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      const SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
}
