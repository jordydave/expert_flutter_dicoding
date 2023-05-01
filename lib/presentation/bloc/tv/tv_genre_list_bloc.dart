import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/tv/get_tv_genre_list.dart';

part 'tv_genre_list_event.dart';
part 'tv_genre_list_state.dart';

class TvGenreListBloc extends Bloc<TvGenreListEvent, TvGenreListState> {
  final GetTVGenreList _getTvGenreList;

  TvGenreListBloc(this._getTvGenreList) : super(TvGenreListEmpty()) {
    on<GetTvGenreList>(
      (event, emit) async {
        final id = event.id;
        emit(TvGenreListLoading());
        final result = await _getTvGenreList.execute(id);
        result.fold(
          (failure) {
            emit(TvGenreListError(failure.message));
          },
          (data) {
            emit(TvGenreListHasData(data));
          },
        );
      },
    );
  }
}
