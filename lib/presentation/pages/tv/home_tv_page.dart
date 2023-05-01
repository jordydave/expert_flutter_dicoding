import 'package:ditonton/presentation/bloc/tv/tv_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_list_bloc.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/test_styles.dart';
import '../../bloc/tv/now_playing_tv_bloc.dart';
import '../../bloc/tv/popular_tv_bloc.dart';
import '../../bloc/tv/top_rated_tv_bloc.dart';
import '../../widgets/see_more.dart';
import '../../widgets/tv/home_tv_genre_list_widget.dart';
import '../../widgets/tv/home_tv_list_widget.dart';
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
        title: const Text('J-Flix TV'),
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
            /// Genre TV Card
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
                  return GenreListTV(state.result);
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

            /// TV Genre List
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

            /// Now Playing TV

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

            /// Popular TV
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

            /// Top Rated TV
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
