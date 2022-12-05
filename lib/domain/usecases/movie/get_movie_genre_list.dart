import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/utils/failure.dart';

class GetMoviesGenreList {
  final MovieRepository repository;

  GetMoviesGenreList(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieGenreList(id);
  }
}
