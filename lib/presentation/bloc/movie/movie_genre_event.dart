part of 'movie_genre_bloc.dart';

abstract class MovieGenreEvent extends Equatable {
  const MovieGenreEvent();

  @override
  List<Object> get props => [];
}

class GetMovieGenre extends MovieGenreEvent {}

