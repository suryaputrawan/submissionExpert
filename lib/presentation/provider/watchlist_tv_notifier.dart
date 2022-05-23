import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvSeries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvNotifier({required this.getWatchlistTvSeries});

  Future<void> fetchWatchListTvSeries() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold((failure) {
      _watchlistTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeries) {
      _watchlistTvState = RequestState.Loaded;
      _watchlistTvSeries = tvSeries;
      notifyListeners();
    });
  }
}
