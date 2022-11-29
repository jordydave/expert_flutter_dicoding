import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
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
