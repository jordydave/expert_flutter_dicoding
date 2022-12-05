import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';

import '../../../utils/failure.dart';
import '../../entities/genre.dart';

class GetTVGenre {
  final TVRepository repository;

  GetTVGenre(this.repository);

  Future<Either<Failure, List<Genre>>> execute() {
    return repository.getGenreTV();
  }
}
