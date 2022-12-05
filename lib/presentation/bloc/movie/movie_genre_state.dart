part of 'movie_genre_bloc.dart';

abstract class MovieGenreState extends Equatable {
  const MovieGenreState();

  @override
  List<Object> get props => [];
}

class MovieGenreEmpty extends MovieGenreState {}

class MovieGenreLoading extends MovieGenreState {}

class MovieGenreHasData extends MovieGenreState {
  final List<Genre> result;

  const MovieGenreHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieGenreError extends MovieGenreState {
  final String message;

  const MovieGenreError(this.message);

  @override
  List<Object> get props => [message];
}
