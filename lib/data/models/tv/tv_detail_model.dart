import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/tv_detail.dart';
import '../genre_model.dart';

class TVDetailResponse extends Equatable {
  const TVDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.tagline,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String type;
  final double voteAverage;
  final int voteCount;
  final String tagline;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVDetailResponse(
        tagline: json["tagline"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
          json["genres"].map(
            (x) => GenreModel.fromJson(x),
          ),
        ),
        homepage: json["homepage"],
        id: json["id"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(
          json["origin_country"].map((x) => x),
        ),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        status: json["status"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(
          genres.map(
            (x) => x.toJson(),
          ),
        ),
        "homepage": homepage,
        "id": id,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(
          originCountry.map((x) => x),
        ),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "tagline": tagline,
      };

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        id,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        type,
        voteAverage,
        voteCount,
      ];
}
