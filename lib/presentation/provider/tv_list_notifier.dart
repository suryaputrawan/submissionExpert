import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];
  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _nowPopularTv = <TvSeries>[];
  List<TvSeries> get nowPopularTv => _nowPopularTv;

  RequestState _nowPopularState = RequestState.Empty;
  RequestState get nowPopularState => _nowPopularState;

  var _nowTopRatedTv = <TvSeries>[];
  List<TvSeries> get nowTopRatedTv => _nowTopRatedTv;

  RequestState _nowTopRatedState = RequestState.Empty;
  RequestState get nowTopRatedState => _nowTopRatedState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTv = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _nowPopularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _nowPopularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPopularState = RequestState.Loaded;
        _nowPopularTv = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _nowTopRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _nowTopRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowTopRatedState = RequestState.Loaded;
        _nowTopRatedTv = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
