import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> moviesFromDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return getMockMovieListForTest() ?? [];
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream.value(null);
  }

  @override
  MovieVO getMovieDetails(int movieId) {
    return moviesFromDatabaseMock.values.toList().first;
  }

  @override
  Stream<MovieVO> getMovieDetailsStream(int movieId) {
    return Stream.value(getMockMovieListForTest()?.first ?? MovieVO());
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMovieListForTest()?.isNotEmpty ?? false) {
      if (getMockMovieListForTest() != null) {
        return getMockMovieListForTest()!
            .where((element) => element.isNowPlaying ?? false)
            .toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  MovieVO? getSingleMovieById(int movieId) {
    return getMockMovieListForTest()?.first;
  }

  @override
  List<MovieVO> getUpComingMovies() {
    if (getMockMovieListForTest()?.isNotEmpty ?? false) {
      if (getMockMovieListForTest() != null) {
        return getMockMovieListForTest()!
            .where((element) => element.isUpcoming ?? false)
            .toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getUpComingMoviesStream() {
    return Stream.value(getUpComingMovies());
  }

  @override
  void saveMovies(List<MovieVO> movieList) {
    movieList.forEach((movie) {
      moviesFromDatabaseMock[movie.id ?? 0] = movie;
    });
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    moviesFromDatabaseMock[movie.id ?? 0] = movie;
  }
}
