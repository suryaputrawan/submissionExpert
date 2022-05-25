import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/search_tvSeries.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesSearchBloc.state, SearchEmpty());
  });

  final tTvSeriesModel = TvSeries(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    firstAirDate: "2011-04-17",
    genreIds: [10765, 18, 10759],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 479.416,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    voteAverage: 8.4,
    voteCount: 17857,
  );

  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  final tQuery = "Thrones";

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));

        return tvSeriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchLoading(),
            SearchHasData(tTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      });

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return tvSeriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchLoading(),
            SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      });
}
