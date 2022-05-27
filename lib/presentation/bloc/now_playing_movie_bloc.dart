import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies) : super(NowPlayingLoading()) {
    on<OnFetchNowPlaying>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(
          NowPlayingError(failure.message),
        );
      }, (data) {
        emit(
          MovieDataNowPlaying(data),
        );
      });
    });
  }
}
