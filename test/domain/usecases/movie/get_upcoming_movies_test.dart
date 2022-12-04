import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetUpComingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetUpComingMovies(mockMovieRepository);
  });

  final movies = <Movie>[];

  test('should get list of upcoming movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getUpcomingMovies())
        .thenAnswer((_) async => Right(movies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(movies));
  });
}
