import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistLoading()) {
    on<OnFetchWatchlist>((event, emit) async {
      emit(WatchlistLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(
          WatchlistError(failure.message),
        );
      }, (data) {
        emit(
          WatchlistData(data),
        );
      });
    });
  }
}
