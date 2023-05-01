import 'package:ditonton/blocs.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/styles/colors.dart';
import 'package:ditonton/styles/test_styles.dart';
import 'package:ditonton/utils/routes.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:ditonton/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
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
      providers: providers,
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
        onGenerateRoute: AppRouter.generateRoute,
        // onGenerateRoute: (RouteSettings settings) {
        //   final args = settings.arguments;
        //   switch (settings.name) {
        //     case '/home':
        //       return MaterialPageRoute(builder: (_) => const HomeMoviePage());
        //     case PopularMoviesPage.routeName:
        //       return CupertinoPageRoute(
        //           builder: (_) => const PopularMoviesPage());
        //     case TopRatedMoviesPage.routeName:
        //       return CupertinoPageRoute(
        //           builder: (_) => const TopRatedMoviesPage());
        //     case MovieDetailPage.routeName:
        //       return MaterialPageRoute(
        //         builder: (_) => MovieDetailPage(id: args as int),
        //         settings: settings,
        //       );
        //     case SearchPage.routeName:
        //       return CupertinoPageRoute(builder: (_) => const SearchPage());
        //     case SearchTVPage.routeName:
        //       return CupertinoPageRoute(builder: (_) => const SearchTVPage());
        //     case WatchlistMoviesPage.routeName:
        //       return MaterialPageRoute(
        //           builder: (_) => const WatchlistMoviesPage());
        //     case WatchlistTVPage.routeName:
        //       return MaterialPageRoute(builder: (_) => const WatchlistTVPage());
        //     case AboutPage.routeName:
        //       return MaterialPageRoute(builder: (_) => const AboutPage());
        //     case PopularTVPage.routeName:
        //       return MaterialPageRoute(builder: (_) => const PopularTVPage());
        //     case HomeTVPage.routeName:
        //       return MaterialPageRoute(builder: (_) => const HomeTVPage());
        //     case TopRatedTVPage.routeName:
        //       return MaterialPageRoute(builder: (_) => const TopRatedTVPage());
        //     case NowPlayingTVPage.routeName:
        //       return MaterialPageRoute(
        //           builder: (_) => const NowPlayingTVPage());
        //     case UpcomingMoviesPage.routeName:
        //       return MaterialPageRoute(
        //           builder: (_) => const UpcomingMoviesPage());
        //     case MovieVideoPlayerPage.routeName:
        //       if (args is List) {
        //         return MaterialPageRoute(
        //           builder: (_) => MovieVideoPlayerPage(
        //             videos: args[0],
        //             movie: args[1],
        //           ),
        //         );
        //       }
        //       break;
        //     case TVDetailpage.routeName:
        //       final id = settings.arguments as int;
        //       return MaterialPageRoute(
        //         builder: (_) => TVDetailpage(id: id),
        //         settings: settings,
        //       );
        //     default:
        //       return MaterialPageRoute(builder: (_) {
        //         return const Scaffold(
        //           body: Center(
        //             child: Text('Page not found :('),
        //           ),
        //         );
        //       });
        //   }
        //   return null;
        // },
      ),
    );
  }
}
