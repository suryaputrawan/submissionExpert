import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;

  MovieWatchlistStatusBloc(
      {required this.getWatchListStatus,
      required this.removeWatchlist,
      required this.saveWatchlist})
      : super(MovieWatchlistStatusLoading()) {
    on<OnLoadWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(MovieWatchlistStatusLoading());

      final result = await getWatchListStatus.execute(id);

      emit(MovieWatchlistStatusIsAdded(result));
    });

    on<OnAddMovieWatchlistStatus>((event, emit) async {
      final movie = event.movieDetail;
      final movieId = movie.id;

      emit(MovieWatchlistStatusLoading());

      final result = await saveWatchlist.execute(movie);
      final isAddedtoWatchlist = await getWatchListStatus.execute(movieId);

      result.fold((failure) {
        emit(
          MovieWatchlistStatusError(failure.message),
        );
      }, (data) async {
        emit(MovieWatchlistStatusIsAdded(isAddedtoWatchlist));
      });
    });

    on<OnRemoveWatchlistStatus>((event, emit) async {
      final movie = event.movieDetail;
      final movieId = movie.id;

      emit(MovieWatchlistStatusLoading());

      final result = await removeWatchlist.execute(movie);
      final isAddedtoWatchlist = await getWatchListStatus.execute(movieId);

      result.fold((failure) {
        emit(
          MovieWatchlistStatusError(failure.message),
        );
      }, (success) async {
        emit(MovieWatchlistStatusIsAdded(isAddedtoWatchlist));
      });
    });
  }
}
