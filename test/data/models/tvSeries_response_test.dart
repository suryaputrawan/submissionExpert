import 'dart:convert';

import 'package:ditonton/data/models/tvSeries_model.dart';
import 'package:ditonton/data/models/tvSeries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final testTvSeriesModel = TvSeriesModel(
    backdropPath: "/path.jpg",
    firstAirDate: "1972-09-04",
    genreIds: [],
    id: 1,
    name: "name",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final testTvSeriesResponse =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[testTvSeriesModel]);

  group('from Json', () {
    test('return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));

      final result = TvSeriesResponse.fromJson(jsonMap);

      expect(result, testTvSeriesResponse);
    });
  });

  group('to JSON', () {
    test('return a JSON map containing proper data', () async {
      final result = testTvSeriesResponse.toJson();

      final expectedJSON = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "1972-09-04",
            "genre_ids": [],
            "id": 1,
            "name": "name",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };

      expect(result, expectedJSON);
    });
  });
}
