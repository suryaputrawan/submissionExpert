part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnAddMovieWatchlistStatus(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveWatchlistStatus extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnRemoveWatchlistStatus(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;

  OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
