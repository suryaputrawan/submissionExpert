part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingLoading extends NowPlayingMovieState {}

class NowPlayingError extends NowPlayingMovieState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDataNowPlaying extends NowPlayingMovieState {
  final List<Movie> resultNowPlaying;

  MovieDataNowPlaying(this.resultNowPlaying);

  @override
  List<Object> get props => [resultNowPlaying];
}
