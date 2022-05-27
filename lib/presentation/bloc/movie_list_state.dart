part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListDataNowPlaying extends MovieListState {
  final List<Movie> resultNowPlaying;
  final List<Movie> resultPopular;
  final List<Movie> resultTopRated;

  MovieListDataNowPlaying(
      this.resultNowPlaying, this.resultPopular, this.resultTopRated);

  @override
  List<Object> get props => [resultNowPlaying, resultPopular, resultTopRated];
}
