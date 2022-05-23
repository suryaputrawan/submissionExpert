import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlistTv', () {
    test('should return success message when insert to database watchlistTv',
        () async {
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.insertWatchlistTv(testTvSeriesTable);

      expect(result, 'Added to Watchlist Tv');
    });

    test('Throw DatabaseExeption when failed insert to database watchlistTv',
        () async {
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenThrow(Exception());

      final result = dataSource.insertWatchlistTv(testTvSeriesTable);

      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlistTv', () {
    test('Should return success message, when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.removeWatchlistTv(testTvSeriesTable);

      expect(result, 'Remove from Watchlist Tv');
    });

    test('Throw DatabaseExeption when failed remove from database watchlistTv',
        () async {
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenThrow(Exception());

      final result = dataSource.removeWatchlistTv(testTvSeriesTable);

      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TvSeries by Id', () {
    final tId = 1;

    test('Return TvSeries Detail Table when data if found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, testTvSeriesTable);
    });

    test('Return null when data not found', () async {
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, null);
    });
  });

  group('get watchlist tvSeries', () {
    test('return list of TvSeriesTable from Database', () async {
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);

      final result = await dataSource.getWatchlistTv();

      expect(result, [testTvSeriesTable]);
    });
  });
}
