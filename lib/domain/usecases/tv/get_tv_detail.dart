import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv/tv_repository.dart';

class GetTVDetail {
  final TVRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVDetail(id);
  }
}
