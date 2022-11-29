import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie/movie_detail.dart';
import '../entities/tv/tv_detail.dart';
import '../repositories/movie/movie_repository.dart';
import '../repositories/tv/tv_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;
  final TVRepository tvRepository;

  SaveWatchlist(this.repository, this.tvRepository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTV(TVDetail tv) {
    return tvRepository.saveWatchlist(tv);
  }
}
