import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListStatus(mockMovieRepository, mockTVRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
  test('should get watchlist status from repository tv', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.executeTV(1);
    // assert
    expect(result, true);
  });
}
