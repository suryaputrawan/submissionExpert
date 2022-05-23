import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tvSeries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail getTvSeriesDetail;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesDetail = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final testId = 1;

  test('get movie detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(testId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await getTvSeriesDetail.execute(testId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
