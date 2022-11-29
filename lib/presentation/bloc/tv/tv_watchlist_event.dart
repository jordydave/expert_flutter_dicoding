part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetTvWatchlist extends TvWatchlistEvent {}

class TvWatchlistStatus extends TvWatchlistEvent {
  final int id;

  const TvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvWatchlist extends TvWatchlistEvent {
  final TVDetail tvDetail;

  const AddTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTvWatchlist extends TvWatchlistEvent {
  final TVDetail tvDetail;

  const RemoveTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
