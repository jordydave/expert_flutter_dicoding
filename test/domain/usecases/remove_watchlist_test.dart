import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlist(mockMovieRepository, mockTVRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.executeTV(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
