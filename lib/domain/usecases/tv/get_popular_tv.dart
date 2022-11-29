import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv/tv_repository.dart';
class GetPopularTV {
  final TVRepository repository;

  GetPopularTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTV();
  }
}
