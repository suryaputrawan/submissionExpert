import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations tvRecommendations;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    tvRecommendations = GetTvRecommendations(mockTvSeriesRepository);
  });

  final testId = 1;
  final testTvSeries = <TvSeries>[];

  test('get list of tv series recommendations from the repository', () async {
    when(mockTvSeriesRepository.getTvRecommendations(testId))
        .thenAnswer((_) async => Right(testTvSeries));

    final result = await tvRecommendations.execute(testId);

    expect(result, Right(testTvSeries));
  });
}
