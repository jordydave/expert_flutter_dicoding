import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/popular_tv_bloc.dart';
import '../../widgets/tv/tv_card_list.dart';

class PopularTVPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTVPage({Key? key}) : super(key: key);

  @override
  State<PopularTVPage> createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (BuildContext context, int index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
              );
            } else if (state is PopularTvError) {
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
