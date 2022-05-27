import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc(
      {required this.getNowPlayingMovies,
      required this.getPopularMovies,
      required this.getTopRatedMovies})
      : super(MovieListLoading()) {
    on<OnFetchMovieList>((event, emit) async {
      emit(MovieListLoading());

      final resultNowPlaying = await getNowPlayingMovies.execute();
      final resultPopular = await getPopularMovies.execute();
      final resultTopRated = await getTopRatedMovies.execute();

      late List<Movie> dataNowPlaying;
      late List<Movie> dataPopular;
      late List<Movie> dataTopRated;

      resultNowPlaying.fold(
        (failure) {
          emit(
            MovieListError(failure.message),
          );
        },
        (data) {
          dataNowPlaying = data;
        },
      );

      resultPopular.fold((failure) {
        emit(
          MovieListError(failure.message),
        );
      }, (data) {
        dataPopular = data;
      });

      resultTopRated.fold((failure) {
        emit(
          MovieListError(failure.message),
        );
      }, (data) {
        dataTopRated = data;
      });

      emit(MovieListDataNowPlaying(dataNowPlaying, dataPopular, dataTopRated));
    });
  }
}
