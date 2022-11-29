
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/movie/get_popular_movies.dart';


part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovie;

  PopularMovieBloc(this._getPopularMovie) : super(PopularMovieEmpty()) {
    on<GetPopularMovie>(
      (event, emit) async {
        emit(PopularMovieLoading());
        final result = await _getPopularMovie.execute();
        result.fold(
          (failure) {
            emit(PopularMovieError(failure.message));
          },
          (data) {
            emit(PopularMovieHasData(data));
          },
        );
      },
    );
  }
}
