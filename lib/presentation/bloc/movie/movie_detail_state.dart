part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> recommendations;
  final List<Movie> similar;
  final List<Videos> videos;
  const MovieDetailHasData(
    this.movieDetail,
    this.recommendations,
    this.similar,
    this.videos,
  );

  @override
  List<Object> get props => [
        movieDetail,
        recommendations,
        similar,
        videos,
      ];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
