import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_genre_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/upcoming_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_genre_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_bloc.dart';
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
import 'package:ditonton/styles/colors.dart';
import 'package:ditonton/styles/test_styles.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:ditonton/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SSLPinning.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UpcomingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieGenreBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieGenreListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvGenreListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvGenreBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FilmFinder',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: args as int),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case SearchTVPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchTVPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
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
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingTVPage());
            case UpcomingMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const UpcomingMoviesPage());
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
        },
      ),
    );
  }
}
