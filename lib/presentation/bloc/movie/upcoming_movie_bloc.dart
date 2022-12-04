import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie/movie.dart';

part 'upcoming_movie_event.dart';
part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final GetUpComingMovies _getUpcomingMovie;

  UpcomingMovieBloc(this._getUpcomingMovie) : super(UpcomingMovieEmpty()) {
    on<GetUpcomingMovie>((event, emit) async {
      emit(UpcomingMovieLoading());
      final result = await _getUpcomingMovie.execute();
      result.fold(
        (failure) {
          emit(UpcomingMovieError(failure.message));
        },
        (data) {
          emit(UpcomingMovieHasData(data));
        },
      );
    });
  }
}
