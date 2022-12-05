import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/genre.dart';
import '../../entities/tv/tv.dart';
import '../../entities/tv/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTV();
  Future<Either<Failure, List<TV>>> getPopularTV();
  Future<Either<Failure, List<TV>>> getTVGenreList(int id);
  Future<Either<Failure, List<Genre>>> getGenreTV();
  Future<Either<Failure, List<TV>>> getTopRatedTV();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTV(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
  Future<Either<Failure, List<TV>>> getTVSimilar(int id);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTV();
}
