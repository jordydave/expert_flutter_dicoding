
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/movie/search_movies.dart';
import '../../../utils/constant.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
