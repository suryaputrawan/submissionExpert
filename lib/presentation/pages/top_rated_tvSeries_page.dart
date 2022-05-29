import 'package:ditonton/presentation/bloc/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/tvSeries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TvSeriesTopRatedBloc>().add(OnFetchTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final result = state.result[index];
                  return TvSeriesCard(result);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvSeriesTopRatedError) {
              return Center(
                child: Text(state.message),
                key: Key('error_message'),
              );
            } else {
              return Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
