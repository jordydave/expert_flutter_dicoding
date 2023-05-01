import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie/movie_detail_bloc.dart';
import '../../bloc/movie/movie_watchlist_bloc.dart';
import '../../widgets/movie/detail_movie_body.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;
  const MovieDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(GetMovieDetails(widget.id));
      context.read<MovieWatchlistBloc>().add(MovieWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddToWatchList = context.select<MovieWatchlistBloc, bool>(
      (bloc) {
        if (bloc.state is MovieWatchlistAdded) {
          return (bloc.state as MovieWatchlistAdded).isAdd;
        } else {
          return false;
        }
      },
    );

    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.movieDetail;
            final movieRecommendations = state.recommendations;
            final movieSimilar = state.similar;
            final videos = state.videos;
            return SafeArea(
              child: DetailMovieBody(
                movie,
                movieRecommendations,
                isMovieAddToWatchList,
                movieSimilar,
                videos,
              ),
            );
          } else if (state is MovieDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
