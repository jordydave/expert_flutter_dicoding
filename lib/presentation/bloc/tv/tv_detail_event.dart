part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTVDetails extends TvDetailEvent {
  final int id;

  const GetTVDetails(this.id);

  @override
  List<Object> get props => [id];
}
