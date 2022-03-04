import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);

    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getSingleMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  //Reactive

  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((movie) => movie.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  List<MovieVO> getUpComingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((movie) => movie.isUpcoming ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<MovieVO>> getUpComingMoviesStream() {
    return Stream.value(getUpComingMovies());
  }

  MovieVO getMovieDetails(int movieId){
    if(getSingleMovieById(movieId)?.id != null){
      return getSingleMovieById(movieId) ?? MovieVO();
    }else{
      return MovieVO();
    }
  }

  Stream<MovieVO> getMovieDetailsStream(int movieId){
    return Stream.value(getMovieDetails(movieId));
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
