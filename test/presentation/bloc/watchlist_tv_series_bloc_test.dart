import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvSeries.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));

        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchWatchlistTvSeries(),
          ),
      expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesData([testWatchlistTvSeries]),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get watchlist data is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchWatchlistTvSeries(),
          ),
      expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      });
}
