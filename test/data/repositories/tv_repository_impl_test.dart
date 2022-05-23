import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tvSeries_detail_model.dart';
import 'package:ditonton/data/models/tvSeries_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repositoryImpl;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
    repositoryImpl = TvRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvSeriesLocalDataSource,
    );
  });

  final testTvSeriesModel = TvSeriesModel(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    firstAirDate: "2011-04-17",
    genreIds: [10765, 18, 10759],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 479.416,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    voteAverage: 8.4,
    voteCount: 17857,
  );

  final testTvSeries = TvSeries(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    firstAirDate: "2011-04-17",
    genreIds: [10765, 18, 10759],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 479.416,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    voteAverage: 8.4,
    voteCount: 17857,
  );

  final testTvSeriesModelList = <TvSeriesModel>[testTvSeriesModel];
  final testTvSeriesList = <TvSeries>[testTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'return remote data when the call to remote data source is successful ',
        () async {
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => testTvSeriesModelList);

      final result = await repositoryImpl.getNowPlayingTvSeries();

      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());

      final resultLits = result.getOrElse(() => []);

      expect(resultLits, testTvSeriesList);
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());

      final result = await repositoryImpl.getNowPlayingTvSeries();

      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(SocketException('Failed to conected to network'));

      final result = await repositoryImpl.getNowPlayingTvSeries();

      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());

      expect(result,
          equals(Left(ConnectionFailure('Failed to conected to network'))));
    });
  });

  group('Popular Tv Series', () {
    test('return tv series list when call to data source is success', () async {
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => testTvSeriesModelList);

      final result = await repositoryImpl.getPopularTvSeries();

      verify(mockTvRemoteDataSource.getPopularTvSeries());

      final resultLits = result.getOrElse(() => []);

      expect(resultLits, testTvSeriesList);
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());

      final result = await repositoryImpl.getPopularTvSeries();

      verify(mockTvRemoteDataSource.getPopularTvSeries());

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to conected to network'));

      final result = await repositoryImpl.getPopularTvSeries();

      verify(mockTvRemoteDataSource.getPopularTvSeries());

      expect(result,
          equals(Left(ConnectionFailure('Failed to conected to network'))));
    });
  });

  group('Top Rated Tv Series', () {
    test('return tv series list when call to data source is success', () async {
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => testTvSeriesModelList);

      final result = await repositoryImpl.getTopRatedTvSeries();

      verify(mockTvRemoteDataSource.getTopRatedTvSeries());

      final resultLits = result.getOrElse(() => []);

      expect(resultLits, testTvSeriesList);
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());

      final result = await repositoryImpl.getTopRatedTvSeries();

      verify(mockTvRemoteDataSource.getTopRatedTvSeries());

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to conected to network'));

      final result = await repositoryImpl.getTopRatedTvSeries();

      verify(mockTvRemoteDataSource.getTopRatedTvSeries());

      expect(result,
          equals(Left(ConnectionFailure('Failed to conected to network'))));
    });
  });

  group('Get Tv Series Detail', () {
    final testId = 1;

    final testTvSeriesResponse = TvSeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 35, name: 'Comedy')],
      homePage: 'homepage',
      id: 1,
      inProduction: false,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 6,
      numberOfSeasons: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 0.6,
      posterPath: 'posterPath',
      seasons: [SeasonModel(id: 1, name: 'Season 1')],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 9.5,
      voteCount: 1,
    );

    test(
        'should return Tv Series data when the call to remote data source is successful',
        () async {
      when(mockTvRemoteDataSource.getTVSeriesDetail(testId))
          .thenAnswer((_) async => testTvSeriesResponse);

      final result = await repositoryImpl.getTvSeriesDetail(testId);

      verify(mockTvRemoteDataSource.getTVSeriesDetail(testId));

      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.getTVSeriesDetail(testId))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getTvSeriesDetail(testId);

      verify(mockTvRemoteDataSource.getTVSeriesDetail(testId));

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.getTVSeriesDetail(testId))
          .thenThrow(SocketException('Failed to conected to network'));

      final result = await repositoryImpl.getTvSeriesDetail(testId);

      verify(mockTvRemoteDataSource.getTVSeriesDetail(testId));

      expect(result,
          equals(Left(ConnectionFailure('Failed to conected to network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final testTvSeriesList = <TvSeriesModel>[];
    final testId = 1;

    test('return data Tv Series List when call success', () async {
      when(mockTvRemoteDataSource.getTvRecommendations(testId))
          .thenAnswer((_) async => testTvSeriesList);

      final result = await repositoryImpl.getTvRecommendations(testId);

      verify(mockTvRemoteDataSource.getTvRecommendations(testId));

      final resultList = result.getOrElse(() => []);

      expect(resultList, equals(testTvSeriesList));
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.getTvRecommendations(testId))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getTvRecommendations(testId);

      verify(mockTvRemoteDataSource.getTvRecommendations(testId));

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.getTvRecommendations(testId))
          .thenThrow(SocketException('Failed to conected to network'));

      final result = await repositoryImpl.getTvRecommendations(testId);

      verify(mockTvRemoteDataSource.getTvRecommendations(testId));

      expect(result,
          equals(Left(ConnectionFailure('Failed to conected to network'))));
    });
  });

  group('Search Tv Series', () {
    final testQuery = 'thrones';

    test('return Tv Series list when call successful', () async {
      when(mockTvRemoteDataSource.searchTvSeries(testQuery))
          .thenAnswer((_) async => testTvSeriesModelList);

      final result = await repositoryImpl.searchTvSeries(testQuery);

      verify(mockTvRemoteDataSource.searchTvSeries(testQuery));

      final resultList = result.getOrElse(() => []);

      expect(resultList, testTvSeriesList);
    });

    test(
        'return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvRemoteDataSource.searchTvSeries(testQuery))
          .thenThrow(ServerException());

      final result = await repositoryImpl.searchTvSeries(testQuery);

      verify(mockTvRemoteDataSource.searchTvSeries(testQuery));

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'return connection failure when the device is not connected to internet',
        () async {
      when(mockTvRemoteDataSource.searchTvSeries(testQuery))
          .thenThrow(SocketException('Failed to connected to network'));

      final result = await repositoryImpl.searchTvSeries(testQuery);

      verify(mockTvRemoteDataSource.searchTvSeries(testQuery));

      expect(result,
          equals(Left(ConnectionFailure('Failed to connected to network'))));
    });
  });

  group('Save Watchlist TV', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist Tv');
      // act
      final result = await repositoryImpl.saveWatchlistTv(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist Tv'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.insertWatchlistTv(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repositoryImpl.saveWatchlistTv(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Removed Watchlist Tv', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repositoryImpl.removeWatchListTv(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.removeWatchlistTv(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repositoryImpl.removeWatchListTv(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Tv Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final testId = 1;
      when(mockTvSeriesLocalDataSource.getTvSeriesById(testId))
          .thenAnswer((_) async => null);
      // act
      final result = await repositoryImpl.addedToWatchListTv(testId);
      // assert
      expect(result, false);
    });
  });

  group('Get Watchlit Tv', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repositoryImpl.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
