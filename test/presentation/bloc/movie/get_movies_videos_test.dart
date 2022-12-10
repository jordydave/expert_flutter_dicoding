import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/video.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_video.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMoviesVideos usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMoviesVideos(mockMovieRepository);
  });

  const tId = 1;
  final tVideos = <Videos>[];

  test('should get list of movie videos from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieVideo(tId))
        .thenAnswer((_) async => Right(tVideos));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tVideos));
  });
}
