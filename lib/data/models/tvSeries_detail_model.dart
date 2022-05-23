import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tvSeries_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homePage,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homePage;
  final int id;
  final bool inProduction;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homePage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["poster_path"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homePage,
        "id": id,
        "in_production": inProduction,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        adult: this.adult,
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homePage: this.homePage,
        id: this.id,
        inProduction: this.inProduction,
        lastAirDate: this.lastAirDate,
        name: this.name,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        seasons: this.seasons.map((season) => season.toEntity()).toList(),
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        firstAirDate,
        genres,
        homePage,
        id,
        inProduction,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
