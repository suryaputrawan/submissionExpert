import 'package:ditonton/presentation/bloc/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/tvSeries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TvSeriesPopularBloc>().add(OnFetchPopularTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final result = state.result[index];

                  return TvSeriesCard(result);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvSeriesPopularError) {
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
