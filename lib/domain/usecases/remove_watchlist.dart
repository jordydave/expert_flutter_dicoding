import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie/movie_detail.dart';
import '../entities/tv/tv_detail.dart';
import '../repositories/movie/movie_repository.dart';
import '../repositories/tv/tv_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;
  final TVRepository tvRepository;

  RemoveWatchlist(this.repository, this.tvRepository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTV(TVDetail tv) {
    return tvRepository.removeWatchlist(tv);
  }
}
