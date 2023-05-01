import 'package:cached_network_image/cached_network_image.dart';
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
import '../../pages/tv/tv_detail_page.dart';
import '../../pages/tv/watchlist_tv_page.dart';

// ignore: must_be_immutable
class DetailTVBody extends StatefulWidget {
  final TVDetail tv;
  final List<TV> reccomendations;
  final List<TV> similarTV;
  bool isAddedWatchlist;

  DetailTVBody(
    this.tv,
    this.reccomendations,
    this.isAddedWatchlist,
    this.similarTV, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailTVBody> createState() => _DetailTVBodyState();
}

class _DetailTVBodyState extends State<DetailTVBody> {
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
                                final isAdded = await toggleWatchlist(
                                  widget.tv,
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
                            Visibility(
                              visible: widget.tv.overview.isNotEmpty,
                              child: Text(
                                'Overview',
                                style: kHeading6,
                              ),
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: widget.reccomendations.isNotEmpty,
                              child: Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                            ),
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
                            Visibility(
                              visible: widget.similarTV.isNotEmpty,
                              child: Text(
                                'Similar',
                                style: kHeading6,
                              ),
                            ),
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
    final message = isAdded ? 'TV Add to Watchlist' : 'TV Remove to Watchlist';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(message),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, WatchlistTVPage.routeName);
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

  Future<bool> toggleWatchlist(TVDetail tv, BuildContext context) async {
    final bloc = context.read<TvWatchlistBloc>();
    final isAddedWatchlist = !widget.isAddedWatchlist;

    if (isAddedWatchlist) {
      bloc.add(AddTvWatchlist(tv));
    } else {
      bloc.add(RemoveTvWatchlist(tv));
    }

    final state = BlocProvider.of<TvWatchlistBloc>(context).state;

    if (state is TvWatchlistAdded) {
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
}
