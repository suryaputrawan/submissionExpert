import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchListTv saveWatchListTv;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    saveWatchListTv = SaveWatchListTv(mockTvSeriesRepository);
  });

  test('save watchlist Tv to repository', () async {
    when(mockTvSeriesRepository.saveWatchlistTv(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added data to Watchlist Tv'));

    final result = await saveWatchListTv.execute(testTvSeriesDetail);

    expect(result, Right('Added data to Watchlist Tv'));
  });
}
