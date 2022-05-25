import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/search_tvSeries.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries _searchTvSeries;

  TvSeriesSearchBloc(this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(
            SearchError(failure.message),
          );
        },
        (data) {
          emit(
            SearchHasData(data),
          );
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
