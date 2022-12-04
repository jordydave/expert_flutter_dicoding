import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie/top_rated_movie_bloc.dart';
import '../../bloc/movie/upcoming_movie_bloc.dart';
import '../../widgets/movie/movie_card_list.dart';

class UpcomingMoviesPage extends StatefulWidget {
  static const routeName = '/upcoming-movie';

  const UpcomingMoviesPage({Key? key}) : super(key: key);

  @override
  UpcomingMoviesPageState createState() => UpcomingMoviesPageState();
}

class UpcomingMoviesPageState extends State<UpcomingMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UpcomingMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is UpcomingMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
