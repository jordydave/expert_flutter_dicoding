import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';

import '../../../utils/failure.dart';

class GetMoviesGenre {
  final MovieRepository repository;

  GetMoviesGenre(this.repository);

  Future<Either<Failure, List<Genre>>> execute() {
    return repository.getGenreMovies();
  }
}
