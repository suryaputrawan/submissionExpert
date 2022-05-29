import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_status_event.dart';
part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusBloc
    extends Bloc<TvSeriesWatchlistStatusEvent, TvSeriesWatchlistStatusState> {
  final GetWatchListStatusTv getWatchListStatusTv;
  final RemoveWatchListTv removeWatchListTv;
  final SaveWatchListTv saveWatchListTv;

  TvSeriesWatchlistStatusBloc({
    required this.getWatchListStatusTv,
    required this.removeWatchListTv,
    required this.saveWatchListTv,
  }) : super(TvSeriesWatchlistStatusLoading()) {
    on<OnLoadTvSeriesWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(TvSeriesWatchlistStatusLoading());

      final result = await getWatchListStatusTv.execute(id);

      emit(TvSeriesWatchlistStatusIsAdded(result));
    });

    on<OnAddTvSeriesWatchlistStatus>((event, emit) async {
      final tvSeries = event.tvSeriesDetail;
      final tvSeriesId = tvSeries.id;

      emit(TvSeriesWatchlistStatusLoading());

      final result = await saveWatchListTv.execute(tvSeries);
      final isAddedtoWatchlist = await getWatchListStatusTv.execute(tvSeriesId);

      result.fold((failure) {
        emit(
          TvSeriesWatchlistStatusError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesWatchlistStatusIsAdded(isAddedtoWatchlist),
        );
      });
    });

    on<OnRemoveTvSeriesWatchlistStatus>((event, emit) async {
      final tvSeries = event.tvSeriesDetail;
      final tvSeriesId = tvSeries.id;

      emit(TvSeriesWatchlistStatusLoading());

      final result = await removeWatchListTv.execute(tvSeries);
      final isAddedtoWatchlist = await getWatchListStatusTv.execute(tvSeriesId);

      result.fold((failure) {
        emit(
          TvSeriesWatchlistStatusError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesWatchlistStatusIsAdded(isAddedtoWatchlist),
        );
      });
    });
  }
}
