part of 'tv_genre_bloc.dart';

abstract class TvGenreEvent extends Equatable {
  const TvGenreEvent();

  @override
  List<Object> get props => [];
}

class GetTvGenre extends TvGenreEvent {}
