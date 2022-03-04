import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

abstract class TheMovieDbDataAgent {
  Future<List<MovieVO>?> getNowPlayingMovies();
  Future<List<MovieVO>?> getUpcomingMovies();
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<ActorVO>?> getCreditsByMovie(int movieId);
  Future<List<GenreVO>?> getGenres();
}
