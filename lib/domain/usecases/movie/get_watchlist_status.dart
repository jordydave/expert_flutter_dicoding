

import '../../repositories/movie/movie_repository.dart';
import '../../repositories/tv/tv_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;
  final TVRepository tvRepository;
  GetWatchListStatus(this.repository, this.tvRepository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }

  Future<bool> executeTV(int id) async {
    return tvRepository.isAddedToWatchlist(id);
  }
}
