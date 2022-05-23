import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/presentation/pages/tvSeries_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvSeries_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockTvDetailNotifier;

  setUp(() {
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockTvDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist, callback',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TvSeries>[]);
    when(mockTvDetailNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockTvDetailNotifier.addToWatchListTv).thenReturn(false);

    final btnIconWatchlist = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(btnIconWatchlist, findsOneWidget);
  });

  testWidgets(
      'Watchlist should display check icon when tv series added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TvSeries>[]);
    when(mockTvDetailNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockTvDetailNotifier.addToWatchListTv).thenReturn(true);

    final btnIconWatchlist = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(btnIconWatchlist, findsOneWidget);
  });

  testWidgets(
      'Watchlist should display snackbar when tv series added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TvSeries>[]);
    when(mockTvDetailNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockTvDetailNotifier.addToWatchListTv).thenReturn(false);
    when(mockTvDetailNotifier.watchListTvMessage)
        .thenReturn('Added to watchlist Tv');

    final btnWatchlistTv = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(btnWatchlistTv);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to watchlist Tv'), findsOneWidget);
  });

  testWidgets(
      'Watchlist should display alert dialog when tv series added to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TvSeries>[]);
    when(mockTvDetailNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockTvDetailNotifier.addToWatchListTv).thenReturn(false);
    when(mockTvDetailNotifier.watchListTvMessage).thenReturn('Failed');

    final btnWatchlistTv = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(btnWatchlistTv);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
