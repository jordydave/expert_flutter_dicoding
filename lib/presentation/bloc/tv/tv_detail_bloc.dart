import 'package:ditonton/domain/usecases/tv/get_tv_similar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/usecases/tv/get_tv_detail.dart';
import '../../../domain/usecases/tv/get_tv_reccomendations.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail _getTVDetails;
  final GetTVRecommendations _getTVRecommendations;
  final GetTVSimilar _getTVSimilar;

  TvDetailBloc(
    this._getTVDetails,
    this._getTVRecommendations,
    this._getTVSimilar,
  ) : super(TvDetailEmpty()) {
    on<GetTVDetails>((event, emit) async {
      final id = event.id;
      emit(TvDetailLoading());
      final result = await _getTVDetails.execute(id);
      final recommendationResult = await _getTVRecommendations.execute(id);
      final similarResult = await _getTVSimilar.execute(id);
      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (data) {
          emit(
            TvDetailHasData(
              data,
              recommendationResult.getOrElse(
                () => [],
              ),
              similarResult.getOrElse(
                () => [],
              ),
            ),
          );
        },
      );
    });
  }
}
