import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie/movie.dart';
import '../../repositories/movie/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
