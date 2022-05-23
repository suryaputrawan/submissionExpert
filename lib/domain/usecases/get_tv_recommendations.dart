import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/repositories/tvSeries_repository.dart';

class GetTvRecommendations {
  final TvSeriesRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
