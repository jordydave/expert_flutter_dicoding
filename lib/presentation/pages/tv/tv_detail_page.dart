import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../styles/colors.dart';
import '../../../styles/test_styles.dart';
import '../../../utils/constant.dart';
import '../../bloc/tv/tv_detail_bloc.dart';
import '../../bloc/tv/tv_watchlist_bloc.dart';

class TVDetailpage extends StatefulWidget {
  static const routeName = '/detail-tv';
  final int id;

  const TVDetailpage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TVDetailpage> createState() => _TVDetailpageState();
}

class _TVDetailpageState extends State<TVDetailpage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<TvDetailBloc>().add(GetTVDetails(widget.id));
        context.read<TvWatchlistBloc>().add(TvWatchlistStatus(widget.id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTvAddToWatchList = context.select<TvWatchlistBloc, bool>(
      (bloc) {
        if (bloc.state is TvWatchlistAdded) {
          return (bloc.state as TvWatchlistAdded).isAdd;
        } else {
          return false;
        }
      },
    );
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.tvDetail;
            final tvRecommendations = state.recommendations;
            final tvSimilar = state.similar;
            return SafeArea(
              child: DetailContent(
                tv,
                tvRecommendations,
                isTvAddToWatchList,
                tvSimilar,
              ),
            );
          } else if (state is TvDetailError) {
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

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final TVDetail tv;
  final List<TV> reccomendations;
  final List<TV> similarTV;
  bool isAddedWatchlist;

  DetailContent(
    this.tv,
    this.reccomendations,
    this.isAddedWatchlist,
    this.similarTV, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${widget.tv.posterPath}',
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
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(AddTvWatchlist(widget.tv));
                                } else {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(RemoveTvWatchlist(widget.tv));
                                }
                                final state =
                                    BlocProvider.of<TvWatchlistBloc>(context)
                                        .state;
                                String message = '';

                                if (state is TvWatchlistAdded) {
                                  final isAdded = state.isAdd;
                                  message = isAdded == false
                                      ? 'TV Add to Watchlist'
                                      : 'TV Remove to Watchlist';
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? 'TV Add to Watchlist'
                                      : 'TV Remove to Watchlist';
                                }
                                if (message == 'TV Add to Watchlist' ||
                                    message == 'TV Remove to Watchlist') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(message),
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    WatchlistTVPage.routeName);
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
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }
                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
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
                              _showGenres(widget.tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoRed,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            widget.tv.overview.isNotEmpty
                                ? Text(
                                    'Overview',
                                    style: kHeading6,
                                  )
                                : const SizedBox(),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            widget.reccomendations.isNotEmpty
                                ? Text(
                                    'Recommendations',
                                    style: kHeading6,
                                  )
                                : const SizedBox(),
                            BlocBuilder<TvDetailBloc, TvDetailState>(
                              builder: (context, state) {
                                if (state is TvDetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvDetailHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv =
                                            widget.reccomendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailpage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$baseImageUrl${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.reccomendations.length,
                                    ),
                                  );
                                } else if (state is TvDetailError) {
                                  return Text(state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            widget.similarTV.isNotEmpty
                                ? Text(
                                    'Similar',
                                    style: kHeading6,
                                  )
                                : const SizedBox(),
                            BlocBuilder<TvDetailBloc, TvDetailState>(
                              builder: (context, state) {
                                if (state is TvDetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvDetailHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = widget.similarTV[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailpage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$baseImageUrl${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.similarTV.length,
                                    ),
                                  );
                                } else if (state is TvDetailError) {
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
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
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
}
