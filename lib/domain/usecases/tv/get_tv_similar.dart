import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv/tv_repository.dart';

class GetTVSimilar {
  final TVRepository repository;

  GetTVSimilar(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getTVSimilar(id);
  }
}
