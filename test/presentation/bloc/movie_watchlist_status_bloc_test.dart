import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
])
void main() {
  late MovieWatchlistStatusBloc movieWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    movieWatchlistStatusBloc = MovieWatchlistStatusBloc(
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emit [Loading, isAdded] when load Status isAdded',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnLoadWatchlistStatus(testMovieDetail.id),
          ),
      expect: () => [
            MovieWatchlistStatusLoading(),
            MovieWatchlistStatusIsAdded(true),
          ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emit [Loading, isAdded] when add to watchlist status isAdded',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));

        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnAddMovieWatchlistStatus(testMovieDetail),
          ),
      expect: () => [
            MovieWatchlistStatusLoading(),
            MovieWatchlistStatusIsAdded(true),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emit [Loading, Error] when add to watchlist status error',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnAddMovieWatchlistStatus(testMovieDetail),
          ),
      expect: () => [
            MovieWatchlistStatusLoading(),
            MovieWatchlistStatusError('Failed'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emit [Loading, isAdded] when remove watchlist success',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Remove'));

        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnRemoveWatchlistStatus(testMovieDetail),
          ),
      expect: () => [
            MovieWatchlistStatusLoading(),
            MovieWatchlistStatusIsAdded(false),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emit [Loading, Error] when remove watchlist error',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnRemoveWatchlistStatus(testMovieDetail),
          ),
      expect: () => [
            MovieWatchlistStatusLoading(),
            MovieWatchlistStatusError('Failed'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      });
}
