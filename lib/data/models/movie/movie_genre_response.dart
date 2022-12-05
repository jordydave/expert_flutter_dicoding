import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

class MovieGenreResponse extends Equatable {
  final List<GenreModel> genreList;

  const MovieGenreResponse({required this.genreList});

  factory MovieGenreResponse.fromJson(Map<String, dynamic> json) =>
      MovieGenreResponse(
        genreList: List<GenreModel>.from(
          (json["genres"] as List).map(
            (x) => GenreModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(
          genreList.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List<Object> get props => [genreList];
}
