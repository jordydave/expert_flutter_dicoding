
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/usecases/movie/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';
import '../../../domain/usecases/tv/get_watchlist_tv.dart';


part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTV _getWatchlistTV;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  TvWatchlistBloc(
    this._getWatchlistTV,
    this._getWatchListStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(TvWatchlistEmpty()) {
    on<GetTvWatchlist>(
      (event, emit) async {
        emit(TvWatchlistLoading());
        final result = await _getWatchlistTV.execute();
        result.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistHasData(data));
          },
        );
      },
    );
    on<TvWatchlistStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getWatchListStatus.executeTV(id);
        emit(TvWatchlistAdded(result));
      },
    );
    on<AddTvWatchlist>(
      (event, emit) async {
        final tv = event.tvDetail;
        final result = await _saveWatchlist.executeTV(tv);
        result.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistMessage(data));
          },
        );
      },
    );
    on<RemoveTvWatchlist>(
      (event, emit) async {
        final tv = event.tvDetail;
        final result = await _removeWatchlist.executeTV(tv);
        result.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistMessage(data));
          },
        );
      },
    );
  }
}
