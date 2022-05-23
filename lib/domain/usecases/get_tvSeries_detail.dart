import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/domain/repositories/tvSeries_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
