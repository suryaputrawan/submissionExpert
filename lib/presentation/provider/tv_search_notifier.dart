import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/search_tvSeries.dart';
import 'package:flutter/cupertino.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSearchNotifier({required this.searchTvSeries});

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (dataSearch) {
        _searchResult = dataSearch;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
