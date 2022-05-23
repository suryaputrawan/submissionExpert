import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv watchListStatusTv;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    watchListStatusTv = GetWatchListStatusTv(mockTvSeriesRepository);
  });

  final testId = 1;

  test('should get watchlist status tv from repository', () async {
    when(mockTvSeriesRepository.addedToWatchListTv(testId))
        .thenAnswer((_) async => true);

    final result = await watchListStatusTv.execute(testId);

    expect(result, true);
  });
}
