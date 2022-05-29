import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
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

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));

        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchTopRatedTvSeries(),
          ),
      expect: () => [
            TvSeriesTopRatedLoading(),
            TvSeriesTopRatedData(tTvSeries),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      });

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Error] when get top rated data is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchTopRatedTvSeries(),
          ),
      expect: () => [
            TvSeriesTopRatedLoading(),
            TvSeriesTopRatedError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      });
}
