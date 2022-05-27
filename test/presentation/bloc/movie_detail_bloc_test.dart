import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  final tId = 1;

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when added is successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchMovieDetail(tId),
          ),
      expect: () => [
            MovieDetailLoading(),
            MovieDetailData(testMovieDetail),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when added is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(
            OnFetchMovieDetail(tId),
          ),
      expect: () => [
            MovieDetailLoading(),
            MovieDetailError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}
