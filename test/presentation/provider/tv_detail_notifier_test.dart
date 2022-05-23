import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_tvSeries_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvRecommendations,
  SaveWatchListTv,
  GetWatchListStatusTv,
  RemoveWatchListTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockSaveWatchListTv mockSaveWatchListTv;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockRemoveWatchListTv mockRemoveWatchListTv;
  late int listenerCallCount;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockSaveWatchListTv = MockSaveWatchListTv();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockRemoveWatchListTv = MockRemoveWatchListTv();
    listenerCallCount = 0;
    provider = TvDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvRecommendations: mockGetTvRecommendations,
        saveWatchListTv: mockSaveWatchListTv,
        getWatchListStatusTv: mockGetWatchListStatusTv,
        removeWatchListTv: mockRemoveWatchListTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final testId = 1;

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

  final tTvSeries = <TvSeries>[tTv];

  void _arrangeUseCase() {
    when(mockGetTvSeriesDetail.execute(testId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvRecommendations.execute(testId))
        .thenAnswer((realInvocation) async => Right(tTvSeries));
  }

  group('get TvSeries Detail', () {
    test('get data from usecase', () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(testId);

      verify(mockGetTvSeriesDetail.execute(testId));
      verify(mockGetTvRecommendations.execute(testId));
    });

    test('change state to loading when usecase is called', () async {
      _arrangeUseCase();

      provider.fetchTvSeriesDetail(testId);

      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('change tv Series when data is gotten successfully', () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(testId);

      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvSeries, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('change recommendation movies when data is gotten successfully',
        () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(testId);

      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvSeries);
    });
  });

  group('get Tv Series Recommendation', () {
    test('get data from usecase', () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(testId);

      verify(mockGetTvRecommendations.execute(testId));
      expect(provider.tvRecommendations, tTvSeries);
    });

    test('update recommendation state when data is gotten successfully',
        () async {
      _arrangeUseCase();

      await provider.fetchTvSeriesDetail(testId);

      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvSeries);
    });

    test('update error message when request in successful', () async {
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      await provider.fetchTvSeriesDetail(testId);

      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('watchlist TvSerie', () {
    test('get the watchlist status', () async {
      when(mockGetWatchListStatusTv.execute(1)).thenAnswer((_) async => true);

      await provider.loadWatchListStatusTv(1);

      expect(provider.addToWatchListTv, true);
    });

    test('execute save watchlist tv when function called', () async {
      when(mockSaveWatchListTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.addWatchListTv(testTvSeriesDetail);

      verify(mockSaveWatchListTv.execute(testTvSeriesDetail));
    });

    test('execute remove watchlist tv when function called', () async {
      when(mockRemoveWatchListTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      await provider.removeFromWatchListTv(testTvSeriesDetail);

      verify(mockRemoveWatchListTv.execute(testTvSeriesDetail));
    });

    test('update watchlist tv status when add watchlist success', () async {
      when(mockSaveWatchListTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.addWatchListTv(testTvSeriesDetail);

      verify(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id));
      expect(provider.addToWatchListTv, true);
      expect(provider.watchListTvMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('update watchlist tv message when add watchlist failed', () async {
      when(mockSaveWatchListTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      await provider.addWatchListTv(testTvSeriesDetail);

      expect(provider.watchListTvMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  test('return error when data is unsuccessful', () async {
    when(mockGetTvSeriesDetail.execute(testId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    when(mockGetTvRecommendations.execute(testId))
        .thenAnswer((_) async => Right(tTvSeries));

    await provider.fetchTvSeriesDetail(testId);

    expect(provider.tvState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
