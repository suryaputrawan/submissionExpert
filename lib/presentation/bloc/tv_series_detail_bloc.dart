import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvSeries_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailBloc(this.getTvSeriesDetail) : super(TvSeriesDetailLoading()) {
    on<OnFetchTvSeriesDetail>((event, emit) async {
      final id = event.id;

      emit(TvSeriesDetailLoading());

      final result = await getTvSeriesDetail.execute(id);

      result.fold((failure) {
        emit(
          TvSeriesDetailError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesDetailData(data),
        );
      });
    });
  }
}
