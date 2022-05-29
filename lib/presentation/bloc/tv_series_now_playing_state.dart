part of 'tv_series_now_playing_bloc.dart';

abstract class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {}

class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;

  TvSeriesNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesNowPlayingData extends TvSeriesNowPlayingState {
  final List<TvSeries> result;

  TvSeriesNowPlayingData(this.result);

  @override
  List<Object> get props => [result];
}
