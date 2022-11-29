
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_now_playing_tv.dart';


part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTV _getNowPlayingTv;

  NowPlayingTvBloc(this._getNowPlayingTv) : super(NowPlayingTvEmpty()) {
    on<GetNowPlayingTv>(
      (event, emit) async {
        emit(NowPlayingTvLoading());
        final result = await _getNowPlayingTv.execute();
        result.fold(
          (failure) {
            emit(NowPlayingTvError(failure.message));
          },
          (data) {
            emit(NowPlayingTvHasData(data));
          },
        );
      },
    );
  }
}
