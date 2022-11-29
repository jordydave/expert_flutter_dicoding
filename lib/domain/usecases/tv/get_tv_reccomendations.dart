import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv/tv_repository.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTVRecommendations(id);
  }
}
