part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetMovieWatchlist extends MovieWatchlistEvent {}

class MovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  const MovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const AddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const RemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
