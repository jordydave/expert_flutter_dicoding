import 'package:equatable/equatable.dart';

import '../genre.dart';

class TVDetail extends Equatable {
  const TVDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
