import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';
import 'package:ditonton/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TVRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
