import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvSeries.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this.getWatchlistTvSeries)
      : super(WatchlistTvSeriesLoading()) {
    on<OnFetchWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await getWatchlistTvSeries.execute();

      result.fold((failure) {
        emit(
          WatchlistTvSeriesError(failure.message),
        );
      }, (data) {
        emit(
          WatchlistTvSeriesData(data),
        );
      });
    });
  }
}
