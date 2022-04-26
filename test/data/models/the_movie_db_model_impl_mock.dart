import 'package:movie_booking_app/data/models/the_movie_db_model.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';

import '../../mock_data/mock_data.dart';

class TheMovieDbModelImplMock extends TheMovieDbModel {
  @override
  void getCreditsByMovie(int movieId) {
    // No need to mock
  }

  @override
  Stream<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId) {
    return Stream.value(getMockActors() ?? []);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenres() ?? []);
  }

  @override
  Future<String> getGenresById(List<int> idList) {
    return Future.value(getMockGenres()?.first.name);
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenres() ?? []);
  }

  @override
  void getMovieDetails(int movieId) {
    // no need to mock
  }
  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Stream.value(getMockMovieListForTest()?.first);
  }

  @override
  void getNowPlayingMovies() {
    // No need to mock
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Stream.value(getMockMovieListForTest()
        ?.where((movie) => movie.isNowPlaying ?? false)
        .toList());
  }

  @override
  void getUpcomingMovies() {
    // No need to Mock
  }

  @override
  Stream<List<MovieVO>?> getUpcomingMoviesFromDatabase() {
      return Stream.value(getMockMovieListForTest()
        ?.where((movie) => movie.isUpcoming ?? false)
        .toList());
  }
}
