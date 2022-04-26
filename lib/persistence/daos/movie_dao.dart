import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

abstract class MovieDao {
  void saveMovies(List<MovieVO> movieList);

  void saveSingleMovie(MovieVO movie);

  List<MovieVO> getAllMovies();

  MovieVO? getSingleMovieById(int movieId);

  //Reactive

  Stream<void> getAllMoviesEventStream();

  List<MovieVO> getNowPlayingMovies();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  List<MovieVO> getUpComingMovies();

  Stream<List<MovieVO>> getUpComingMoviesStream();

  MovieVO getMovieDetails(int movieId);

  Stream<MovieVO> getMovieDetailsStream(int movieId);

 
}
