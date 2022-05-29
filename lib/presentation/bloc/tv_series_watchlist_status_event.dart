part of 'tv_series_watchlist_status_bloc.dart';

abstract class TvSeriesWatchlistStatusEvent extends Equatable {
  const TvSeriesWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnLoadTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final int id;

  OnLoadTvSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnAddTvSeriesWatchlistStatus(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class OnRemoveTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnRemoveTvSeriesWatchlistStatus(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
