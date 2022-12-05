import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_genre.dart';
import 'package:equatable/equatable.dart';

part 'movie_genre_event.dart';
part 'movie_genre_state.dart';

class MovieGenreBloc extends Bloc<MovieGenreEvent, MovieGenreState> {
  final GetMoviesGenre _getMovieGenre;

  MovieGenreBloc(
    this._getMovieGenre,
  ) : super(MovieGenreEmpty()) {
    on<GetMovieGenre>(
      (event, emit) async {
        emit(MovieGenreLoading());
        final result = await _getMovieGenre.execute();
        result.fold(
          (failure) {
            emit(MovieGenreError(failure.message));
          },
          (data) {
            emit(MovieGenreHasData(data));
          },
        );
      },
    );
  }
}
