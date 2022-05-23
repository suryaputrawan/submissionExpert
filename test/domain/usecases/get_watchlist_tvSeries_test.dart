import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries watchlistTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    watchlistTvSeries = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('get list of tv series from the repository', () async {
    when(mockTvSeriesRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvSeriesList));

    final result = await watchlistTvSeries.execute();

    expect(result, Right(testTvSeriesList));
  });
}
