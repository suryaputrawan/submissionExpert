import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/presentation/pages/popular_tvSeries_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvSeries_page.dart';
import 'package:ditonton/presentation/pages/tvSeries_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv';
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTvSeries()
      ..fetchPopularTvSeries()
      ..fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.nowPlayingTv);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular TV',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPopularState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.nowPopularTv);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated TV',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowTopRatedState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.nowTopRatedTv);
              } else {
                return Text('Failed');
              }
            }),
          ],
        )),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              Text('See More'),
              Icon(Icons.arrow_forward_ios),
            ]),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TvSeriesDetailPage.ROUTE_NAME,
                    arguments: tv.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
