import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie/movie.dart';
import '../../repositories/movie/movie_repository.dart';

class GetMovieSimilar {
  final MovieRepository repository;

  GetMovieSimilar(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieSimilar(id);
  }
}
