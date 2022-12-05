part of 'tv_genre_list_bloc.dart';

abstract class TvGenreListEvent extends Equatable {
  const TvGenreListEvent();

  @override
  List<Object> get props => [];
}

class GetTvGenreList extends TvGenreListEvent {
  final int id;

  GetTvGenreList(this.id);
}
