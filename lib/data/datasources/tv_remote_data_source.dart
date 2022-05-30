import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvSeries_detail_model.dart';
import 'package:ditonton/data/models/tvSeries_model.dart';
import 'package:ditonton/data/models/tvSeries_response.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailResponse> getTVSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificate_tv.cer');

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    return securityContext;
  }

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    IOClient ioClient = IOClient(client);

    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    // final response =
    //     await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;

    // IOClient ioClient = IOClient(client);

    // final response =
    //     await ioClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;

    // IOClient ioClient = IOClient(client);

    // final response =
    //     await ioClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTVSeriesDetail(int id) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;

    // IOClient ioClient = IOClient(client);

    // final response = await ioClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvRecommendations(int id) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;

    // IOClient ioClient = IOClient(client);

    // final response = await ioClient
    //     .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    // HttpClient client = HttpClient(context: await globalContext);
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => false;

    // IOClient ioClient = IOClient(client);

    // final response = await ioClient
    //     .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
