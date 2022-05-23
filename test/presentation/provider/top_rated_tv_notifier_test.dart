import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvNotifier provider;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    listenerCallCount = 1;
    provider = TopRatedTvNotifier(mockGetTopRatedTvSeries)
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
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    provider.fetchTopRatedTvSeries();

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 2);
  });

  test('change tv series data when data is gotten successfully', () async {
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    await provider.fetchTopRatedTvSeries();

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tTvSeriesList);
    expect(listenerCallCount, 3);
  });

  test('return error when data is unsuccessful', () async {
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await provider.fetchTopRatedTvSeries();

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 3);
  });
}
