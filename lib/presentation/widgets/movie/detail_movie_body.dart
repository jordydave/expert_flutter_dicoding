import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/genre.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/movie/movie_detail.dart';
import '../../../domain/entities/movie/video.dart';
import '../../../styles/colors.dart';
import '../../../styles/test_styles.dart';
import '../../../utils/constant.dart';
import '../../bloc/movie/movie_detail_bloc.dart';
import '../../bloc/movie/movie_watchlist_bloc.dart';
import '../../pages/movie/movie_detail_page.dart';
import '../../pages/movie/movie_video_player_page.dart';
import '../../pages/movie/watchlist_movies_page.dart';
import 'detail_movie_card.dart';
import 'detail_movie_video_card.dart';

// ignore: must_be_immutable
class DetailMovieBody extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final List<Movie> similiarMovie;
  final List<Videos> videos;
  bool isAddedWatchlist;

  DetailMovieBody(
    this.movie,
    this.recommendations,
    this.isAddedWatchlist,
    this.similiarMovie,
    this.videos, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailMovieBody> createState() => _DetailMovieBodyState();
}

class _DetailMovieBodyState extends State<DetailMovieBody> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final isAdded = await toggleWatchlist(
                                  widget.movie,
                                  context,
                                );
                                showWatchlistSnackbar(isAdded);
                                setState(() {
                                  widget.isAddedWatchlist = isAdded;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoRed,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: widget.videos.isNotEmpty,
                              child: Text(
                                "Video",
                                style: kHeading6,
                              ),
                            ),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                if (state is MovieDetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieDetailHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final video = widget.videos[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) {
                                                    return MovieVideoPlayerPage(
                                                      videos: widget.videos,
                                                      movie: widget.movie,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: DetailMovieVideoCard(
                                              videos: video,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.videos.length,
                                    ),
                                  );
                                } else if (state is MovieDetailError) {
                                  return Text(state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                if (state is MovieDetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieDetailHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child:
                                                DetailMovieCard(movie: movie),
                                          ),
                                        );
                                      },
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else if (state is MovieDetailError) {
                                  return Text(state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: widget.similiarMovie.isNotEmpty,
                              child: Text(
                                'Similar',
                                style: kHeading6,
                              ),
                            ),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                if (state is MovieDetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieDetailHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            widget.similiarMovie[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child:
                                                DetailMovieCard(movie: movie),
                                          ),
                                        );
                                      },
                                      itemCount: widget.similiarMovie.length,
                                    ),
                                  );
                                } else if (state is MovieDetailError) {
                                  return Text(state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void showWatchlistSnackbar(bool isAdded) {
    final message =
        isAdded ? 'Movie Add to Watchlist' : 'Movie Remove to Watchlist';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(message),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
                },
                child: Text(
                  "Go To Watchlist",
                  style: kBodyText.copyWith(
                    color: kPrussianRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> toggleWatchlist(MovieDetail movie, BuildContext context) async {
    final bloc = context.read<MovieWatchlistBloc>();
    final isAddedWatchlist = !widget.isAddedWatchlist;

    if (isAddedWatchlist) {
      bloc.add(AddMovieWatchlist(movie));
    } else {
      bloc.add(RemoveMovieWatchlist(movie));
    }

    final state = BlocProvider.of<MovieWatchlistBloc>(context).state;

    if (state is MovieWatchlistAdded) {
      return state.isAdd;
    } else {
      return isAddedWatchlist;
    }
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
