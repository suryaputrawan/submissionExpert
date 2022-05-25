part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends TvSeriesSearchState {}

class SearchLoading extends TvSeriesSearchState {}

class SearchError extends TvSeriesSearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends TvSeriesSearchState {
  final List<TvSeries> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
