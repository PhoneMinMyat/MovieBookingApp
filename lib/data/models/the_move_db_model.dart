import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

abstract class TheMovieDbModel {
  //Network
  void getNowPlayingMovies();
  void getUpcomingMovies();
  void getMovieDetails(int movieId);
  Future<List<ActorVO>?> getCreditsByMovie(int movieId);
  Future<List<GenreVO>?> getGenres();

  //Database
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>?> getUpcomingMoviesFromDatabase();
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);
  Future<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId);
  Future<List<GenreVO>?> getGenresFromDatabase();

  Future<String> getGenresById(List<int> idList);
}
