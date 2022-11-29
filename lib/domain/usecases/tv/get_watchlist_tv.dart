import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv/tv_repository.dart';

class GetWatchlistTV {
  final TVRepository _repository;

  GetWatchlistTV(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTV();
  }
}
