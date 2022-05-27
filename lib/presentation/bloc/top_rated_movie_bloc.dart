import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedLoading()) {
    on<OnFetchTopRated>((event, emit) async {
      emit(TopRatedLoading());

      final result = await getTopRatedMovies.execute();

      result.fold((failure) {
        emit(
          TopRatedError(failure.message),
        );
      }, (data) {
        emit(
          MovieDataTopRated(data),
        );
      });
    });
  }
}
