import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/search_tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries searchTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    searchTvSeries = SearchTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  final testQuery = 'Thrones';

  test('get list of Tv Series from repository', () async {
    when(mockTvSeriesRepository.searchTvSeries(testQuery))
        .thenAnswer((_) async => Right(testTvSeries));

    final result = await searchTvSeries.execute(testQuery);

    expect(result, Right(testTvSeries));
  });
}
