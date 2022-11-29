import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvModel = TVModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: "Name",
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tTvResponseModel = TVResponse(tvList: <TVModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2020-05-05",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Name",
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
