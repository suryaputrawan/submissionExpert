part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailData extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;

  TvSeriesDetailData(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
