import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/genre.dart';
import '../../../domain/usecases/tv/get_tv_genre.dart';

part 'tv_genre_event.dart';
part 'tv_genre_state.dart';

class TvGenreBloc extends Bloc<TvGenreEvent, TvGenreState> {
  final GetTVGenre _getTvGenre;

  TvGenreBloc(this._getTvGenre) : super(TvGenreEmpty()) {
    on<GetTvGenre>((event, emit) async {
      emit(TvGenreLoading());
      final result = await _getTvGenre.execute();
      result.fold(
        (failure) {
          emit(TvGenreError(failure.message));
        },
        (data) {
          emit(TvGenreHasData(data));
        },
      );
    });
  }
}
