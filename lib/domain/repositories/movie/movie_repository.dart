import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';

import '../../../utils/failure.dart';
import '../../entities/movie/movie.dart';
import '../../entities/movie/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getUpcomingMovies();
  Future<Either<Failure, List<Genre>>> getGenreMovies();
  Future<Either<Failure, List<Movie>>> getMovieGenreList(int id);
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> getMovieSimilar(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
