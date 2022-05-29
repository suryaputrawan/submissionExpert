import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvSeries.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
  });

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

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));

        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchPopularTvSeries(),
          ),
      expect: () => [
            TvSeriesPopularLoading(),
            TvSeriesPopularData(tTvSeries),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, Error] when get popular tv series is unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchPopularTvSeries(),
          ),
      expect: () => [
            TvSeriesPopularLoading(),
            TvSeriesPopularError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });
}
