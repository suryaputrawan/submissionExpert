import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvSeries_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  final tId = 1;

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, HasData] when added is successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));

        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchTvSeriesDetail(tId),
          ),
      expect: () => [
            TvSeriesDetailLoading(),
            TvSeriesDetailData(testTvSeriesDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when added is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchTvSeriesDetail(tId),
          ),
      expect: () => [
            TvSeriesDetailLoading(),
            TvSeriesDetailError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      });
}
