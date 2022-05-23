import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/domain/repositories/tvSeries_repository.dart';

class RemoveWatchListTv {
  final TvSeriesRepository repository;

  RemoveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchListTv(tvSeries);
  }
}
