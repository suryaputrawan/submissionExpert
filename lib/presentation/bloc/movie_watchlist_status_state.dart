part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusLoading extends MovieWatchlistStatusState {}

class MovieWatchlistStatusError extends MovieWatchlistStatusState {
  final String message;

  MovieWatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusIsAdded extends MovieWatchlistStatusState {
  final bool isAddedtoWatchlist;

  MovieWatchlistStatusIsAdded(this.isAddedtoWatchlist);

  @override
  List<Object> get props => [isAddedtoWatchlist];
}
