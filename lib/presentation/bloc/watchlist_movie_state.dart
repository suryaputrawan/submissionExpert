part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistLoading extends WatchlistMovieState {}

class WatchlistError extends WatchlistMovieState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistData(this.result);

  @override
  List<Object> get props => [result];
}
