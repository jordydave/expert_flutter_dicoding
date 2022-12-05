import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_genre.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_similar.dart';
import 'package:ditonton/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/upcoming_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_bloc.dart';
import 'package:ditonton/utils/network_info.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie/movie_local_data_source.dart';
import 'data/datasources/movie/movie_remote_data_source.dart';
import 'data/datasources/tv/tv_local_data_source.dart';
import 'data/datasources/tv/tv_remote_data_source.dart';
import 'data/repositories/movie/movie_repository_impl.dart';
import 'data/repositories/tv/tv_repository_impl.dart';
import 'domain/repositories/movie/movie_repository.dart';
import 'domain/repositories/tv/tv_repository.dart';
import 'domain/usecases/movie/get_movie_detail.dart';
import 'domain/usecases/movie/get_movie_genre_list.dart';
import 'domain/usecases/movie/get_movie_recommendations.dart';
import 'domain/usecases/movie/get_now_playing_movies.dart';
import 'domain/usecases/movie/get_popular_movies.dart';
import 'domain/usecases/movie/get_top_rated_movies.dart';
import 'domain/usecases/movie/get_watchlist_movies.dart';
import 'domain/usecases/movie/get_watchlist_status.dart';
import 'domain/usecases/movie/search_movies.dart';
import 'domain/usecases/remove_watchlist.dart';
import 'domain/usecases/save_watchlist.dart';
import 'domain/usecases/tv/get_now_playing_tv.dart';
import 'domain/usecases/tv/get_popular_tv.dart';
import 'domain/usecases/tv/get_top_rated_tv.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_reccomendations.dart';
import 'domain/usecases/tv/get_watchlist_tv.dart';
import 'domain/usecases/tv/search_tv.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => UpcomingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieGenreBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieGenreListBloc(
      locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetMoviesGenre(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMoviesGenreList(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieSimilar(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator(), locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetUpComingMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSrouceImpl(client: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
