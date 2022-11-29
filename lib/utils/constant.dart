import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
const String apiKey = 'api_key=209b5843e9c301c02d3f1f6073a22cf8';
const String baseUrl = 'https://api.themoviedb.org/3';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
