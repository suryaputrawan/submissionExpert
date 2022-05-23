import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvSeries.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvNotifier provider;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    listenerCallCount = 1;
    provider =
        WatchlistTvNotifier(getWatchlistTvSeries: mockGetWatchlistTvSeries)
          ..addListener(() {
            listenerCallCount += 1;
          });
  });

  test('change tv series data when data is gotten successfully', () async {
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([testWatchlistTvSeries]));

    await provider.fetchWatchListTvSeries();

    expect(provider.watchlistTvState, RequestState.Loaded);
    expect(provider.watchlistTvSeries, [testWatchlistTvSeries]);
    expect(listenerCallCount, 3);
  });

  test('return error when data is unsuccessful', () async {
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("No data to loaded")));

    await provider.fetchWatchListTvSeries();

    expect(provider.watchlistTvState, RequestState.Error);
    expect(provider.message, "No data to loaded");
    expect(listenerCallCount, 3);
  });
}
