import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, HasData] when load data is successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));

        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchMovieRecommendations(tId),
          ),
      expect: () => [
            MovieRecommendationsLoading(),
            MovieRecommendationsData(tMovies),
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, Error] when load data is unsuccessfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchMovieRecommendations(tId),
          ),
      expect: () => [
            MovieRecommendationsLoading(),
            MovieRecommendationsError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });
}
