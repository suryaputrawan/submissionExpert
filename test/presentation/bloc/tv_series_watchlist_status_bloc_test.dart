import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTv,
  SaveWatchListTv,
  RemoveWatchListTv,
])
void main() {
  late TvSeriesWatchlistStatusBloc tvSeriesWatchlistStatusBloc;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchListTv mockSaveWatchListTv;
  late MockRemoveWatchListTv mockRemoveWatchListTv;

  setUp(() {
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchListTv = MockSaveWatchListTv();
    mockRemoveWatchListTv = MockRemoveWatchListTv();
    tvSeriesWatchlistStatusBloc = TvSeriesWatchlistStatusBloc(
      getWatchListStatusTv: mockGetWatchListStatusTv,
      removeWatchListTv: mockRemoveWatchListTv,
      saveWatchListTv: mockSaveWatchListTv,
    );
  });

  final id = testTvSeriesDetail.id;

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emit [Loading, isAdded] when load Status isAdded',
      build: () {
        when(mockGetWatchListStatusTv.execute(id))
            .thenAnswer((_) async => true);

        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnLoadTvSeriesWatchlistStatus(id),
          ),
      expect: () => [
            TvSeriesWatchlistStatusLoading(),
            TvSeriesWatchlistStatusIsAdded(true),
          ],
      verify: (bloc) {
        verify(mockGetWatchListStatusTv.execute(id));
      });

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emit [Loading, isAdded] when add to watchlist status isAdded',
      build: () {
        when(mockGetWatchListStatusTv.execute(id))
            .thenAnswer((_) async => true);

        when(mockSaveWatchListTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));

        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnAddTvSeriesWatchlistStatus(testTvSeriesDetail),
          ),
      expect: () => [
            TvSeriesWatchlistStatusLoading(),
            TvSeriesWatchlistStatusIsAdded(true),
          ],
      verify: (bloc) {
        verify(mockSaveWatchListTv.execute(testTvSeriesDetail));
      });

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emit [Loading, Error] when add to watchlist status error',
      build: () {
        when(mockGetWatchListStatusTv.execute(id))
            .thenAnswer((_) async => true);

        when(mockSaveWatchListTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnAddTvSeriesWatchlistStatus(testTvSeriesDetail),
          ),
      expect: () => [
            TvSeriesWatchlistStatusLoading(),
            TvSeriesWatchlistStatusError('Failed'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchListTv.execute(testTvSeriesDetail));
      });

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emit [Loading, isAdded] when remove watchlist success',
      build: () {
        when(mockGetWatchListStatusTv.execute(id))
            .thenAnswer((_) async => false);

        when(mockRemoveWatchListTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Remove from Watchlist'));

        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnRemoveTvSeriesWatchlistStatus(testTvSeriesDetail),
          ),
      expect: () => [
            TvSeriesWatchlistStatusLoading(),
            TvSeriesWatchlistStatusIsAdded(false),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchListTv.execute(testTvSeriesDetail));
      });

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emit [Loading, Error] when remove watchlist error',
      build: () {
        when(mockGetWatchListStatusTv.execute(id))
            .thenAnswer((_) async => false);

        when(mockRemoveWatchListTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(
            OnRemoveTvSeriesWatchlistStatus(testTvSeriesDetail),
          ),
      expect: () => [
            TvSeriesWatchlistStatusLoading(),
            TvSeriesWatchlistStatusError('Failed'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchListTv.execute(testTvSeriesDetail));
      });
}
