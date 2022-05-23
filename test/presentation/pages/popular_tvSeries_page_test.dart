import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/presentation/pages/popular_tvSeries_page.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tvSeries_page_test.mocks.dart';

@GenerateMocks([PopularTvSeriesNotifier])
void main() {
  late MockPopularTvSeriesNotifier mockPopularTvSeriesNotifier;

  setUp(() {
    mockPopularTvSeriesNotifier = MockPopularTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvSeriesNotifier>.value(
      value: mockPopularTvSeriesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTvSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressBar = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('Page should display List View when data loaded',
      (WidgetTester tester) async {
    when(mockPopularTvSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockPopularTvSeriesNotifier.tvSeries).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message Error',
      (WidgetTester tester) async {
    when(mockPopularTvSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockPopularTvSeriesNotifier.message).thenReturn('Error message');

    final textMessageFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(textMessageFinder, findsOneWidget);
  });
}
