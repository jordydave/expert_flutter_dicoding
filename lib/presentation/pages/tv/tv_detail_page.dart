import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_detail_bloc.dart';
import '../../bloc/tv/tv_watchlist_bloc.dart';
import '../../widgets/tv/detail_tv_body.dart';

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
              child: DetailTVBody(
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
