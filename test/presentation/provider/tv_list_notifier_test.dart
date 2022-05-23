import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvListNotifier provider;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    listenerCallCount = 1;
    provider = TvListNotifier(
        getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
        getPopularTvSeries: mockGetPopularTvSeries,
        getTopRatedTvSeries: mockGetTopRatedTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
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

  final tTvSeries = <TvSeries>[tTv];

  group('now playing TvSeries', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('get data from the usecase', () async {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      provider.fetchNowPlayingTvSeries();

      verify(mockGetNowPlayingTvSeries.execute());
    });

    test('change state to Loading when usecase is called', () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('change tv series when data is gotten successfully', () async {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      await provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTv, tTvSeries);
      expect(listenerCallCount, 3);
    });

    test('return error when data is unsuccessful', () async {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });

  group('popular TvSeries', () {
    test('change state to loading when usecase is called', () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      provider.fetchPopularTvSeries();

      expect(provider.nowPopularState, RequestState.Loading);
    });

    test('change tv series data when data is gotten successfully', () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      await provider.fetchPopularTvSeries();

      expect(provider.nowPopularState, RequestState.Loaded);
      expect(provider.nowPopularTv, tTvSeries);
      expect(listenerCallCount, 3);
    });

    test('return error when data is unsuccessful', () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvSeries();

      expect(provider.nowPopularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });

  group('Top Rated Tv Series', () {
    test('change state to loading when usecase is called', () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      provider.fetchTopRatedTvSeries();

      expect(provider.nowTopRatedState, RequestState.Loading);
    });

    test('change tv series data when data is gotten successfully', () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));

      await provider.fetchTopRatedTvSeries();

      expect(provider.nowTopRatedState, RequestState.Loaded);
      expect(provider.nowTopRatedTv, tTvSeries);
      expect(listenerCallCount, 3);
    });

    test('return error when data is unsuccessful', () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTvSeries();

      expect(provider.nowTopRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });
}
