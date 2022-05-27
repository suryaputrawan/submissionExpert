part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDataPopular extends PopularMovieState {
  final List<Movie> resultPopular;

  MovieDataPopular(this.resultPopular);

  @override
  List<Object> get props => [resultPopular];
}
