import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/movie/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<GetTopRatedMovie>(
      (event, emit) async {
        emit(TopRatedMovieLoading());
        final result = await _getTopRatedMovies.execute();
        result.fold(
          (failure) {
            emit(TopRatedMovieError(failure.message));
          },
          (data) {
            emit(TopRatedMovieHasData(data));
          },
        );
      },
    );
  }
}
