import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

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

  final tMovieList = <Movie>[tMovie];

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlaying()),
      expect: () => [
            NowPlayingLoading(),
            MovieDataNowPlaying(tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlaying()),
      expect: () => [
            NowPlayingLoading(),
            NowPlayingError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}
