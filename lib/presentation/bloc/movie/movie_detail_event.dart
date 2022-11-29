part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetails extends MovieDetailEvent {
  final int id;

  const GetMovieDetails(this.id);

  @override
  List<Object> get props => [id];
}
