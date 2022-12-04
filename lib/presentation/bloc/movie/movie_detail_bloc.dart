import 'package:ditonton/domain/usecases/movie/get_movie_similar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/movie/movie_detail.dart';
import '../../../domain/usecases/movie/get_movie_detail.dart';
import '../../../domain/usecases/movie/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetMovieSimilar _getMovieSimilar;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._getMovieSimilar,
  ) : super(MovieDetailEmpty()) {
    on<GetMovieDetails>(
      (event, emit) async {
        final id = event.id;

        emit(MovieDetailLoading());
        final result = await _getMovieDetail.execute(id);
        final recommendationResult = await _getMovieRecommendations.execute(id);
        final similarResult = await _getMovieSimilar.execute(id);
        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            emit(
              MovieDetailHasData(
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
      },
    );
  }
}
