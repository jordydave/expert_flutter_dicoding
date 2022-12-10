import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/video.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/utils/failure.dart';

class GetMoviesVideos {
  final MovieRepository repository;

  GetMoviesVideos(this.repository);

  Future<Either<Failure, List<Videos>>> execute(int movieId) {
    return repository.getMovieVideo(movieId);
  }
}
