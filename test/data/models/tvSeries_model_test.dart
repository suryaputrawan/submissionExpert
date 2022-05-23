import 'package:ditonton/data/models/tvSeries_model.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final testTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a sub class of TvSeries entity', () async {
    final result = testTvSeriesModel.toEntity();

    expect(result, testTvSeries);
  });
}
