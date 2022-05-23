import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvSeries_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTv(TvSeriesTable tvSeries);
  Future<String> removeWatchlistTv(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTv();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTv(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTv(tvSeries);
      return 'Added to Watchlist Tv';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlistTv(tvSeries);
      return 'Remove from Watchlist Tv';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((e) => TvSeriesTable.fromMap(e)).toList();
  }
}
