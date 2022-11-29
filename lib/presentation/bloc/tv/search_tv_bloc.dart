
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/search_tv.dart';
import '../../../utils/constant.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTV _searchTV;

  SearchTvBloc(this._searchTV) : super(SearchTvEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvLoading());
        final result = await _searchTV.execute(query);

        result.fold(
          (failure) {
            emit(SearchTvError(failure.message));
          },
          (data) {
            emit(SearchTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
