part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieWatchlistHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieWatchlistAdded extends MovieWatchlistState {
  final bool isAdd;

  const MovieWatchlistAdded(this.isAdd);

  @override
  List<Object> get props => [isAdd];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String message;

  const MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
