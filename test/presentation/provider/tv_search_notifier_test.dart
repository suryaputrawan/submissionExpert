import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/search_tvSeries.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    listenerCallCount = 1;
    provider = TvSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
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
  final testQuery = "Thrones";

  group('Search Tv Series', () {
    test('change state to loading when usecase is called', () async {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));

      provider.fetchTvSearch(testQuery);

      expect(provider.state, RequestState.Loading);
    });

    test('change search result data when data is gotten successfully',
        () async {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));

      await provider.fetchTvSearch(testQuery);

      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvSeriesList);
      expect(listenerCallCount, 3);
    });

    test('return error when data is unsuccessful', () async {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTvSearch(testQuery);

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });
}
