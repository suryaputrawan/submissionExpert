import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvSeries_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistTvAddSuccessMessage = 'Added to watchlist Tv';
  static const watchlistTvRemoveSuccessMessage = 'Remove from watchlist Tv';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvRecommendations getTvRecommendations;
  final SaveWatchListTv saveWatchListTv;
  final GetWatchListStatusTv getWatchListStatusTv;
  final RemoveWatchListTv removeWatchListTv;

  TvDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvRecommendations,
    required this.saveWatchListTv,
    required this.getWatchListStatusTv,
    required this.removeWatchListTv,
  });

  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeries => _tvSeriesDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _addToWatchListTv = false;
  bool get addToWatchListTv => _addToWatchListTv;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.Loading;
        _tvSeriesDetail = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (tvSeries) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvSeries;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchListTvMessage = '';
  String get watchListTvMessage => _watchListTvMessage;

  Future<void> addWatchListTv(TvSeriesDetail tvSeries) async {
    final result = await saveWatchListTv.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchListTvMessage = failure.message;
      },
      (message) async {
        _watchListTvMessage = message;
      },
    );
    await loadWatchListStatusTv(tvSeries.id);
  }

  Future<void> removeFromWatchListTv(TvSeriesDetail tvSeries) async {
    final result = await removeWatchListTv.execute(tvSeries);

    await result.fold((failure) async {
      _watchListTvMessage = failure.message;
    }, (message) async {
      _watchListTvMessage = message;
    });
    await loadWatchListStatusTv(tvSeries.id);
  }

  Future<void> loadWatchListStatusTv(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _addToWatchListTv = result;
    notifyListeners();
  }
}
