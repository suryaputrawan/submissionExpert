import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistTv(TvSeriesDetail tvSeries);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
  Future<bool> addedToWatchListTv(int id);
  Future<Either<Failure, String>> removeWatchListTv(TvSeriesDetail tvSeries);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
}
