import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvSeries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeries = TvSeries(
  backdropPath: "/rv5gu2gYbOEYoArzH7bqJuMxvBB.jpg",
  firstAirDate: "2021-01-25",
  genreIds: [18, 10751],
  id: 15646,
  name: "Lisa",
  originalName: "Lisa",
  overview:
      "The Price Is Right features a wide variety of games and contests with the same basic challenge: Guess the prices of everyday (or not-quite-everyday) retail items",
  popularity: 1806.531,
  posterPath: "/6m4uYFAJwkanZXd0n0HUQ0lYHLl.jpg",
  voteAverage: 6.3,
  voteCount: 54,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 35, name: 'Comedy')],
  homePage: 'homepage',
  id: 1,
  inProduction: false,
  lastAirDate: 'lastAirDate',
  name: 'name',
  numberOfEpisodes: 6,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 0.6,
  posterPath: 'posterPath',
  seasons: [Season(id: 1, name: "Season 1")],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 9.5,
  voteCount: 1,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
