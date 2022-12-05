import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';
import 'package:ditonton/utils/failure.dart';

class GetTVGenreList {
  final TVRepository repository;

  GetTVGenreList(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTVGenreList(id);
  }
}
