import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/movie/get_movie_genre_list.dart';

part 'movie_genre_list_event.dart';
part 'movie_genre_list_state.dart';

class MovieGenreListBloc
    extends Bloc<MovieGenreListEvent, MovieGenreListState> {
  final GetMoviesGenreList _getMovieGenreList;

  MovieGenreListBloc(
    this._getMovieGenreList,
  ) : super(MovieGenreListEmpty()) {
    on<GetMovieGenreList>(
      (event, emit) async {
        final id = event.id;
        emit(MovieGenreListLoading());
        final result = await _getMovieGenreList.execute(id);
        result.fold(
          (failure) {
            emit(MovieGenreListError(failure.message));
          },
          (data) {
            emit(MovieGenreListHasData(data));
          },
        );
      },
    );
  }
}
