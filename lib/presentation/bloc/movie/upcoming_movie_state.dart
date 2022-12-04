part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

class UpcomingMovieEmpty extends UpcomingMovieState {}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieHasData extends UpcomingMovieState {
  final List<Movie> result;

  const UpcomingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class UpcomingMovieError extends UpcomingMovieState {
  final String message;

  const UpcomingMovieError(this.message);

  @override
  List<Object> get props => [message];
}
