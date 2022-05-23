import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries getPopularTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getPopularTvSeries = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];

  test('get list of tv series from repository', () async {
    when(mockTvSeriesRepository.getPopularTvSeries())
        .thenAnswer((_) async => Right(testTvSeries));

    final result = await getPopularTvSeries.execute();

    expect(result, Right(testTvSeries));
  });
}
