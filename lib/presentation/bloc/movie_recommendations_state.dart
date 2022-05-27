part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsData extends MovieRecommendationsState {
  final List<Movie> resultRecommendations;

  MovieRecommendationsData(this.resultRecommendations);

  @override
  List<Object> get props => [resultRecommendations];
}
