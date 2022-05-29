import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesTopRatedBloc(this.getTopRatedTvSeries)
      : super(TvSeriesTopRatedLoading()) {
    on<OnFetchTopRatedTvSeries>((event, emit) async {
      emit(TvSeriesTopRatedLoading());

      final result = await getTopRatedTvSeries.execute();

      result.fold((failure) {
        emit(
          TvSeriesTopRatedError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesTopRatedData(data),
        );
      });
    });
  }
}
