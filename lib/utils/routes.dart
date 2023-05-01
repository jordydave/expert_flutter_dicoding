import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_video_player_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/upcoming_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeMoviePage());
      case PopularMoviesPage.routeName:
        return MaterialPageRoute(builder: (_) => const PopularMoviesPage());
      case TopRatedMoviesPage.routeName:
        return MaterialPageRoute(builder: (_) => const TopRatedMoviesPage());
      case MovieDetailPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: args as int),
          settings: settings,
        );
      case SearchPage.routeName:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case SearchTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const SearchTVPage());
      case WatchlistMoviesPage.routeName:
        return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
      case WatchlistTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const WatchlistTVPage());
      case AboutPage.routeName:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case PopularTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const PopularTVPage());
      case HomeTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const HomeTVPage());
      case TopRatedTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const TopRatedTVPage());
      case NowPlayingTVPage.routeName:
        return MaterialPageRoute(builder: (_) => const NowPlayingTVPage());
      case UpcomingMoviesPage.routeName:
        return MaterialPageRoute(builder: (_) => const UpcomingMoviesPage());
      case MovieVideoPlayerPage.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (_) => MovieVideoPlayerPage(
              videos: args[0],
              movie: args[1],
            ),
          );
        }
        break;
      case TVDetailpage.routeName:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TVDetailpage(id: id),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
    return null;
  }
}
