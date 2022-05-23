import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(widget.id);
      Provider.of<TvDetailNotifier>(context, listen: false)
          .loadWatchListStatusTv(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, data, child) {
          if (data.tvState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.tvState == RequestState.Loaded) {
            final tvSeries = data.tvSeries;
            return SafeArea(
              child: TvDetailContent(
                tvSeries,
                data.tvRecommendations,
                data.addToWatchListTv,
              ),
            );
          } else {
            return Text(data.message);
          }
        },
      ),
    );
  }
}

class TvDetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool addedWatchListTv;

  TvDetailContent(
    this.tvSeries,
    this.recommendations,
    this.addedWatchListTv,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              padding: EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvSeries.name,
                            style: kHeading5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!addedWatchListTv) {
                                await Provider.of<TvDetailNotifier>(context,
                                        listen: false)
                                    .addWatchListTv(tvSeries);
                              } else {
                                await Provider.of<TvDetailNotifier>(context,
                                        listen: false)
                                    .removeFromWatchListTv(tvSeries);
                              }

                              final message = Provider.of<TvDetailNotifier>(
                                      context,
                                      listen: false)
                                  .watchListTvMessage;

                              if (message ==
                                      TvDetailNotifier
                                          .watchlistTvAddSuccessMessage ||
                                  message ==
                                      TvDetailNotifier
                                          .watchlistTvRemoveSuccessMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    });
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                addedWatchListTv
                                    ? Icon(Icons.check)
                                    : Icon(Icons.add),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                          Text(
                            _tvGenres(tvSeries.genres),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: tvSeries.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    Icon(Icons.star, color: kMikadoYellow),
                                itemSize: 24,
                              ),
                              Text('${tvSeries.voteAverage}'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Episode',
                            style: kHeading6,
                          ),
                          Text(
                            tvSeries.numberOfEpisodes.toString(),
                            style: kHeading5,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Seasons',
                            style: kHeading6,
                          ),
                          Text(
                            _tvSeasons(tvSeries.seasons),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Overview',
                            style: kHeading6,
                          ),
                          Text(tvSeries.overview),
                          SizedBox(height: 16),
                          Text(
                            'Recommendation',
                            style: kHeading6,
                          ),
                          Consumer<TvDetailNotifier>(
                            builder: (context, data, child) {
                              if (data.recommendationState ==
                                  RequestState.Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (data.recommendationState ==
                                  RequestState.Loaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tvSeries = recommendations[index];
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id);
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: recommendations.length,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }

  String _tvGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _tvSeasons(List<Season> seasons) {
    String result = '';
    for (var season in seasons) {
      result += season.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
