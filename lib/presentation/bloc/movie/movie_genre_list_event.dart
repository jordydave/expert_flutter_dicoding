part of 'movie_genre_list_bloc.dart';

abstract class MovieGenreListEvent extends Equatable {
  const MovieGenreListEvent();

  @override
  List<Object> get props => [];
}

class GetMovieGenreList extends MovieGenreListEvent {
  final int id;

  GetMovieGenreList(this.id);

  @override
  List<Object> get props => [id];
}
