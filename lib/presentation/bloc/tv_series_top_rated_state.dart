part of 'tv_series_top_rated_bloc.dart';

abstract class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;

  TvSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedData extends TvSeriesTopRatedState {
  final List<TvSeries> result;

  TvSeriesTopRatedData(this.result);

  @override
  List<Object> get props => [result];
}
