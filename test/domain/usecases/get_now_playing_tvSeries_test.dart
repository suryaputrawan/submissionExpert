import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries nowPlayingTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    nowPlayingTvSeries = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];

  test('get list of tv series from the repository', () async {
    when(mockTvSeriesRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(testTvSeries));

    final result = await nowPlayingTvSeries.execute();

    expect(result, Right(testTvSeries));
  });
}
