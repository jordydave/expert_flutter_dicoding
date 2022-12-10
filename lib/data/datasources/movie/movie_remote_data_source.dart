import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie/movie_genre_response.dart';
import 'package:ditonton/data/models/movie/video_model.dart';
import 'package:ditonton/data/models/movie/video_response.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/exception.dart';
import '../../models/movie/movie_detail_model.dart';
import '../../models/movie/movie_model.dart';
import '../../models/movie/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<GenreModel>> getGenreMovies();
  Future<List<VideosModel>> getMovieVideo(int id);
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> getMovieGenreList(int id);
  Future<List<MovieModel>> getMovieSimilar(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GenreModel>> getGenreMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/genre/movie/list?$apiKey'));

    if (response.statusCode == 200) {
      return MovieGenreResponse.fromJson(json.decode(response.body)).genreList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieSimilar(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/$id/similar?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieGenreList(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/discover/movie?$apiKey&with_genres=$id'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<VideosModel>> getMovieVideo(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/$id/videos?$apiKey'));

    if (response.statusCode == 200) {
      return VideoResponse.fromJson(json.decode(response.body)).videoList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/upcoming?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
