part of 'movie_genre_list_bloc.dart';

abstract class MovieGenreListState extends Equatable {
  const MovieGenreListState();

  @override
  List<Object> get props => [];
}

class MovieGenreListEmpty extends MovieGenreListState {}

class MovieGenreListLoading extends MovieGenreListState {}

class MovieGenreListHasData extends MovieGenreListState {
  final List<Movie> result;

  const MovieGenreListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieGenreListError extends MovieGenreListState {
  final String message;

  const MovieGenreListError(this.message);

  @override
  List<Object> get props => [message];
}
