import 'package:ditonton/domain/repositories/tvSeries_repository.dart';

class GetWatchListStatusTv {
  final TvSeriesRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.addedToWatchListTv(id);
  }
}
