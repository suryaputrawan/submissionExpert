import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularBloc(this.getPopularTvSeries)
      : super(TvSeriesPopularLoading()) {
    on<OnFetchPopularTvSeries>((event, emit) async {
      emit(TvSeriesPopularLoading());

      final result = await getPopularTvSeries.execute();

      result.fold((failure) {
        emit(
          TvSeriesPopularError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesPopularData(data),
        );
      });
    });
  }
}
