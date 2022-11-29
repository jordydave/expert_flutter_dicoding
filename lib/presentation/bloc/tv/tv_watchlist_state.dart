part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistHasData extends TvWatchlistState {
  final List<TV> tvs;

  const TvWatchlistHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistAdded extends TvWatchlistState {
  final bool isAdd;

  const TvWatchlistAdded(this.isAdd);

  @override
  List<Object> get props => [isAdd];
}

class TvWatchlistMessage extends TvWatchlistState {
  final String message;

  const TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
