import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchlistMovies,
      mockGetWatchlistStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });
  test('initial state must be Initial state', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  group('testing watchlist movie', () {
    final tMovie = Movie(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: const [14, 28],
      id: 557,
      originalTitle: 'Spider-Man',
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.2,
      voteCount: 13507,
    );

    final tMovieList = [tMovie];

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, HasData] when get list of watchlist movie successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlist()),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistHasData(tMovieList),
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when get data list of watchlist movie unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure(('Server Failure'))));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlist()),
      expect: () => [
        MovieWatchlistLoading(),
        const MovieWatchlistError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
    );
  });
}
