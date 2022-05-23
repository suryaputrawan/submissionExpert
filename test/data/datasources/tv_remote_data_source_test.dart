import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tvSeries_detail_model.dart';
import 'package:ditonton/data/models/tvSeries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get now playing Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/airing_today.json')))
        .tvSeriesList;

    test('return list of tvSeries model when the response code 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200));

      final result = await dataSource.getNowPlayingTvSeries();

      expect(result, equals(tTvSeriesList));
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getNowPlayingTvSeries();

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvSeries_popular.json')))
        .tvSeriesList;

    test('return list tvSeries when response code 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvSeries_popular.json'), 200));

      final result = await dataSource.getPopularTvSeries();

      expect(result, tTvSeriesList);
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getPopularTvSeries();

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvSeries_top_rated.json')))
        .tvSeriesList;

    test('return list tvSeries when response code 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvSeries_top_rated.json'), 200));

      final result = await dataSource.getTopRatedTvSeries();

      expect(result, tTvSeriesList);
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getTopRatedTvSeries();

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Series Detail', () {
    final testId = 1;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvSeries_detail.json')));

    test('Return Tv Series detail when response code 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvSeries_detail.json'), 200));

      final result = await dataSource.getTVSeriesDetail(testId);

      expect(result, equals(tTvSeriesDetail));
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getTVSeriesDetail(testId);

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Series Recommendation', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvSeries_recommendations.json')))
        .tvSeriesList;

    final testId = 1;

    test('Return list of Tv Series Model when response code 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$testId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvSeries_recommendations.json'), 200));

      final result = await dataSource.getTvRecommendations(testId);

      expect(result, equals(tTvSeriesList));
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$testId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSource.getTvRecommendations(testId);

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Search Tv Series', () {
    final tSearchResult = TvSeriesResponse.fromJson(json.decode(
            readJson('dummy_data/search_game_of_thrones_tvSeries.json')))
        .tvSeriesList;

    final testQuery = 'thrones';

    test('Return list of Tv Series when status response code 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$testQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_game_of_thrones_tvSeries.json'),
              200));

      final result = await dataSource.searchTvSeries(testQuery);

      expect(result, tSearchResult);
    });

    test('should throw the ServerException when the response code 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$testQuery')))
          .thenAnswer(
              (realInvocation) async => http.Response('Not Found', 404));

      final result = dataSource.searchTvSeries(testQuery);

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
