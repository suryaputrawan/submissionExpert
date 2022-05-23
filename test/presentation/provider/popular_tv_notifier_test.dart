import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesNotifier provider;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    listenerCallCount = 1;
    provider = PopularTvSeriesNotifier(mockGetPopularTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTv];

  test('change state to loading when usecase is called', () async {
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 2);
  });

  test('change movies data when data is gotten successfully', () async {
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    await provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tTvSeriesList);
    expect(listenerCallCount, 3);
  });

  test('return error when data is unsuccessful', () async {
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 3);
  });
}
