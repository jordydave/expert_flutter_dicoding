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
import 'package:ditonton/presentation/bloc/tv/tv_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider(
    create: (_) => di.locator<SearchBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<SearchTvBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TopRatedMovieBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<NowPlayingMovieBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<PopularMovieBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<UpcomingMovieBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<NowPlayingTvBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<PopularTvBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TopRatedTvBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<MovieDetailBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<MovieWatchlistBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TvDetailBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TvWatchlistBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<MovieGenreBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<MovieGenreListBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TvGenreListBloc>(),
  ),
  BlocProvider(
    create: (_) => di.locator<TvGenreBloc>(),
  ),
];
