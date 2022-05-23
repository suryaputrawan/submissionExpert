import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries topRatedTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    topRatedTvSeries = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];

  test('get list of tv series from repository', () async {
    when(mockTvSeriesRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(testTvSeries));

    final result = await topRatedTvSeries.execute();

    expect(result, Right(testTvSeries));
  });
}
