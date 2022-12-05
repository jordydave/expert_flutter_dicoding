import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_list_bloc.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../styles/colors.dart';
import '../../../styles/test_styles.dart';
import '../../../utils/constant.dart';
import '../../bloc/tv/now_playing_tv_bloc.dart';
import '../../bloc/tv/popular_tv_bloc.dart';
import '../../bloc/tv/top_rated_tv_bloc.dart';
import '../../widgets/see_more.dart';
import 'now_playing_tv_page.dart';

class HomeTVPage extends StatefulWidget {
  static const routeName = '/home-tv';

  const HomeTVPage({Key? key}) : super(key: key);

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(GetNowPlayingTv());
      context.read<PopularTvBloc>().add(GetPopularTv());
      context.read<TopRatedTvBloc>().add(GetTopRatedTv());
      context.read<TvGenreBloc>().add(GetTvGenre());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton TV'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genre',
              style: kHeading6,
            ),
            BlocBuilder<TvGenreBloc, TvGenreState>(
              builder: (context, state) {
                if (state is TvGenreLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvGenreHasData) {
                  return GenreList(state.result);
                } else if (state is TvGenreError) {
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
            BlocBuilder<TvGenreListBloc, TvGenreListState>(
              builder: (context, state) {
                if (state is TvGenreListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvGenreListHasData) {
                  return TVList(
                    state.result,
                  );
                } else if (state is TvGenreListError) {
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
            SeeMoreWidget(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTVPage.routeName),
            ),
            BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
              builder: (context, state) {
                if (state is NowPlayingTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvHasData) {
                  return TVList(state.result);
                } else if (state is NowPlayingTvError) {
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
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVPage.routeName),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
              builder: (context, state) {
                if (state is PopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvHasData) {
                  return TVList(state.result);
                } else if (state is PopularTvError) {
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
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVPage.routeName),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
              builder: (context, state) {
                if (state is TopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvHasData) {
                  return TVList(state.result);
                } else if (state is TopRatedTvError) {
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
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tv;

  const TVList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final television = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailpage.routeName,
                  arguments: television.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${television.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  GenreList(
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
      context.read<TvGenreListBloc>().add(GetTvGenreList(
            widget.genres.first.id,
          ));
    });
  }

  String selectedGenre = 'Action & Adventure';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
              context.read<TvGenreListBloc>().add(
                    GetTvGenreList(
                      genre.id,
                    ),
                  );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedGenre == genre.name ? kPrussianBlue : kDavysGrey,
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
