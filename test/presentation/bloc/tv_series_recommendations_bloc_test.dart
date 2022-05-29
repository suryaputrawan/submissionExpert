import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvSeriesRecommendationsBloc tvSeriesRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvSeriesRecommendationsBloc =
        TvSeriesRecommendationsBloc(mockGetTvRecommendations);
  });

  final tId = 1;

  final tTv = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = <TvSeries>[tTv];

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
      'Should emit [Loading, HasData] when load data is successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));

        return tvSeriesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchRecommendationsTvSeries(tId),
          ),
      expect: () => [
            TvSeriesRecommendationsLoading(),
            TvSeriesRecommendationsData(tTvSeries),
          ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      });

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
      'Should emit [Loading, Error] when load data is unsuccessfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchRecommendationsTvSeries(tId),
          ),
      expect: () => [
            TvSeriesRecommendationsLoading(),
            TvSeriesRecommendationsError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      });
}
