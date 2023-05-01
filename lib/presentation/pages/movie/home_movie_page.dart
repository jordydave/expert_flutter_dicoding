import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/upcoming_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/upcoming_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../styles/colors.dart';
import '../../../styles/test_styles.dart';
import '../../../utils/constant.dart';
import '../../bloc/movie/movie_genre_list_bloc.dart';
import '../../bloc/movie/now_playing_movie_bloc.dart';
import '../../bloc/movie/popular_movie_bloc.dart';
import '../../bloc/movie/top_rated_movie_bloc.dart';
import '../../widgets/see_more.dart';
import '../about_page.dart';
import '../tv/home_tv_page.dart';
import 'search_page.dart';
import '../tv/watchlist_tv_page.dart';
import 'movie_detail_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(GetNowPlayingMovie());
      context.read<PopularMovieBloc>().add(GetPopularMovie());
      context.read<TopRatedMovieBloc>().add(GetTopRatedMovie());
      context.read<UpcomingMovieBloc>().add(GetUpcomingMovie());
      context.read<MovieGenreBloc>().add(GetMovieGenre());
    });
  }

  String selectedGenre = 'Action';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              accountName: Text('FilmFinder'),
              accountEmail: Text('jordydaveworks@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, HomeTVPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('FilmFinder Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genre',
                style: kHeading6,
              ),
              BlocBuilder<MovieGenreBloc, MovieGenreState>(
                builder: (context, state) {
                  if (state is MovieGenreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieGenreHasData) {
                    return GenreList(state.result);
                  } else if (state is MovieGenreError) {
                    return Center(
                      child: Text(
                        state.message,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<MovieGenreListBloc, MovieGenreListState>(
                builder: (context, state) {
                  if (state is MovieGenreListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieGenreListHasData) {
                    return MovieList(
                      state.result,
                    );
                  } else if (state is MovieGenreListError) {
                    return Center(
                      child: Text(
                        state.message,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMovieHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SeeMoreWidget(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularMoviesPage.routeName,
                ),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                builder: (context, state) {
                  if (state is PopularMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMovieHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SeeMoreWidget(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedMoviesPage.routeName,
                ),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMovieHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SeeMoreWidget(
                title: 'Upcoming',
                onTap: () => Navigator.pushNamed(
                  context,
                  UpcomingMoviesPage.routeName,
                ),
              ),
              BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                builder: (context, state) {
                  if (state is UpcomingMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UpcomingMovieHasData) {
                    return MovieList(state.result);
                  } else if (state is UpcomingMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  const GenreList(
    this.genres, {
    Key? key,
  }) : super(key: key);

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieGenreListBloc>().add(GetMovieGenreList(
            widget.genres.first.id,
          ));
    });
  }

  String selectedGenre = 'Action';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (BuildContext context, int index) {
          final genre = widget.genres[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGenre = genre.name;
              });
              context.read<MovieGenreListBloc>().add(
                    GetMovieGenreList(
                      genre.id,
                    ),
                  );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedGenre == genre.name ? kPrussianRed : kDavysGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.genres[index].name,
              ),
            ),
          );
        },
      ),
    );
  }
}
