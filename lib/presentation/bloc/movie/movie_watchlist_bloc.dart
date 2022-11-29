import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/movie/movie_detail.dart';
import '../../../domain/usecases/movie/get_watchlist_movies.dart';
import '../../../domain/usecases/movie/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  MovieWatchlistBloc(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(MovieWatchlistEmpty()) {
    on<GetMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistLoading());
        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(MovieWatchlistError(failure.message));
          },
          (data) {
            emit(MovieWatchlistHasData(data));
          },
        );
      },
    );
    on<MovieWatchlistStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getWatchListStatus.execute(id);
        emit(MovieWatchlistAdded(result));
      },
    );
    on<AddMovieWatchlist>(
      (event, emit) async {
        final movie = event.movieDetail;
        final result = await _saveWatchlist.execute(movie);
        result.fold(
          (failure) {
            emit(MovieWatchlistError(failure.message));
          },
          (data) {
            emit(MovieWatchlistMessage(data));
          },
        );
      },
    );
    on<RemoveMovieWatchlist>(
      (event, emit) async {
        final movie = event.movieDetail;
        final result = await _removeWatchlist.execute(movie);
        result.fold(
          (failure) {
            emit(MovieWatchlistError(failure.message));
          },
          (data) {
            emit(MovieWatchlistMessage(data));
          },
        );
      },
    );
  }
}
