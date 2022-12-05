import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_genre_response.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/exception.dart';
import '../../models/genre_model.dart';
import '../../models/tv/tv_detail_model.dart';
import '../../models/tv/tv_model.dart';
import '../../models/tv/tv_response.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getNowPlayingTV();
  Future<List<TVModel>> getPopularTV();
  Future<List<TVModel>> getTopRatedTV();
  Future<List<TVModel>> getTVSimilar(int id);
  Future<TVDetailResponse> getTVDetail(int id);
  Future<List<TVModel>> getTVRecommendations(int id);
  Future<List<GenreModel>> getGenreTV();
  Future<List<TVModel>> getTVGenreList(int id);
  Future<List<TVModel>> searchTV(String query);
}

class TVRemoteDataSrouceImpl implements TVRemoteDataSource {
  final http.Client client;

  TVRemoteDataSrouceImpl({required this.client});

  @override
  Future<List<TVModel>> getNowPlayingTV() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVGenreList(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/discover/tv?$apiKey&with_genres=$id'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVSimilar(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/similar?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GenreModel>> getGenreTV() async {
    final response =
        await client.get(Uri.parse('$baseUrl/genre/tv/list?$apiKey'));

    if (response.statusCode == 200) {
      return TVGenreResponse.fromJson(json.decode(response.body)).genreList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailResponse> getTVDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTV() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/popular?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTV() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTV(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
