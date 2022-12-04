import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_similar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieSimilar usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieSimilar(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];
  test('should get list of movie similar from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getMovieSimilar(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
