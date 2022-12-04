import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie/movie.dart';
import '../../repositories/movie/movie_repository.dart';

class GetUpComingMovies {
  final MovieRepository movieRepository;

  GetUpComingMovies(this.movieRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return movieRepository.getUpcomingMovies();
  }
}
