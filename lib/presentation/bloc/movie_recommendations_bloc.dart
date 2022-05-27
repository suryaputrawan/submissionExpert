import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc(this.getMovieRecommendations)
      : super(MovieRecommendationsLoading()) {
    on<OnFetchMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationsLoading());

      final result = await getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(
          MovieRecommendationsError(failure.message),
        );
      }, (data) {
        emit(
          MovieRecommendationsData(data),
        );
      });
    });
  }
}
