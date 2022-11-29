import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/test_styles.dart';
import '../../bloc/tv/search_tv_bloc.dart';
import '../../widgets/tv/tv_card_list.dart';

class SearchTVPage extends StatelessWidget {
  static const routeName = '/search-tv';

  const SearchTVPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tv = result[index];
                        return TVCard(tv);
                      },
                    ),
                  );
                } else if (state is SearchTvError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
