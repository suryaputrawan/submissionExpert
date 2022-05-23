import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchListTv removeWatchListTv;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    removeWatchListTv = RemoveWatchListTv(mockTvSeriesRepository);
  });

  test('remove watchlist tv from repository', () async {
    when(mockTvSeriesRepository.removeWatchListTv(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlistTv'));

    final result = await removeWatchListTv.execute(testTvSeriesDetail);

    expect(result, Right('Removed from watchlistTv'));
  });
}
