part of 'tv_genre_list_bloc.dart';

abstract class TvGenreListState extends Equatable {
  const TvGenreListState();

  @override
  List<Object> get props => [];
}

class TvGenreListEmpty extends TvGenreListState {}

class TvGenreListLoading extends TvGenreListState {}

class TvGenreListHasData extends TvGenreListState {
  final List<TV> result;

  const TvGenreListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvGenreListError extends TvGenreListState {
  final String message;

  const TvGenreListError(this.message);

  @override
  List<Object> get props => [message];
}