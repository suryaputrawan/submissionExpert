import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendations_event.dart';
part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsBloc
    extends Bloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState> {
  final GetTvRecommendations getTvRecommendations;

  TvSeriesRecommendationsBloc(this.getTvRecommendations)
      : super(TvSeriesRecommendationsLoading()) {
    on<OnFetchRecommendationsTvSeries>((event, emit) async {
      final id = event.id;

      emit(TvSeriesRecommendationsLoading());

      final result = await getTvRecommendations.execute(id);

      result.fold((failure) {
        emit(
          TvSeriesRecommendationsError(failure.message),
        );
      }, (data) {
        emit(
          TvSeriesRecommendationsData(data),
        );
      });
    });
  }
}
