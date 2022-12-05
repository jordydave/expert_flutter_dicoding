part of 'tv_genre_bloc.dart';

abstract class TvGenreState extends Equatable {
  const TvGenreState();

  @override
  List<Object> get props => [];
}

class TvGenreEmpty extends TvGenreState {}

class TvGenreLoading extends TvGenreState {}

class TvGenreHasData extends TvGenreState {
  final List<Genre> result;

  const TvGenreHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvGenreError extends TvGenreState {
  final String message;

  const TvGenreError(this.message);

  @override
  List<Object> get props => [message];
}
