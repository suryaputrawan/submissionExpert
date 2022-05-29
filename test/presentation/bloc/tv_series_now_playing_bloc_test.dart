import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvSeries.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(mockGetNowPlayingTvSeries);
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

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));

        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchNowPlayingTvSeries(),
          ),
      expect: () => [
            TvSeriesNowPlayingLoading(),
            TvSeriesNowPlayingData(tTvSeries),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      });

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, Error] when get now playing tv series is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchNowPlayingTvSeries(),
          ),
      expect: () => [
            TvSeriesNowPlayingLoading(),
            TvSeriesNowPlayingError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      });
}
