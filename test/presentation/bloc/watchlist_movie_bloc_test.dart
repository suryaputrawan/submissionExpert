import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlist()),
      expect: () => [
            WatchlistLoading(),
            WatchlistData([testWatchlistMovie]),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlist()),
      expect: () => [
            WatchlistLoading(),
            WatchlistError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });
}
