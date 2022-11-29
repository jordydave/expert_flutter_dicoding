part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailHasData extends TvDetailState {
  final TVDetail tvDetail;
  final List<TV> recommendations;
  const TvDetailHasData(
    this.tvDetail,
    this.recommendations,
  );

  @override
  List<Object> get props => [
        tvDetail,
        recommendations,
      ];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}
