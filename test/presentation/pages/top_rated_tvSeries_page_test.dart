import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/presentation/pages/top_rated_tvSeries_page.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tvSeries_page_test.mocks.dart';

@GenerateMocks([TopRatedTvNotifier])
void main() {
  late MockTopRatedTvNotifier mockTopRatedTvNotifier;

  setUp(() {
    mockTopRatedTvNotifier = MockTopRatedTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvNotifier>.value(
      value: mockTopRatedTvNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTvNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display List View when data loaded',
      (WidgetTester tester) async {
    when(mockTopRatedTvNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTopRatedTvNotifier.tvSeries).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text message when error',
      (WidgetTester tester) async {
    when(mockTopRatedTvNotifier.state).thenReturn(RequestState.Error);
    when(mockTopRatedTvNotifier.message).thenReturn('Error message');

    final textMessageFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textMessageFinder, findsOneWidget);
  });
}
