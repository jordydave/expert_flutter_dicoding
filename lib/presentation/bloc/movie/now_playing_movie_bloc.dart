
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/movie/get_now_playing_movies.dart';


part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovie;

  NowPlayingMovieBloc(this._getNowPlayingMovie)
      : super(NowPlayingMovieEmpty()) {
    on<NowPlayingMovieEvent>(
      (event, emit) async {
        emit(NowPlayingMovieLoading());
        final result = await _getNowPlayingMovie.execute();
        result.fold(
          (failure) {
            emit(NowPlayingMovieError(failure.message));
          },
          (data) {
            emit(NowPlayingMovieHasData(data));
          },
        );
      },
    );
  }
}
