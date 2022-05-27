part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailData extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
