import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class MovieDaoImpl extends MovieDao{
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);

    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getSingleMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  //Reactive

  @override
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((movie) => movie.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  List<MovieVO> getUpComingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((movie) => movie.isUpcoming ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getUpComingMoviesStream() {
    return Stream.value(getUpComingMovies());
  }

  @override
  MovieVO getMovieDetails(int movieId){
    if(getSingleMovieById(movieId)?.id != null){
      return getSingleMovieById(movieId) ?? MovieVO();
    }else{
      return MovieVO();
    }
  }

  @override
  Stream<MovieVO> getMovieDetailsStream(int movieId){
    return Stream.value(getMovieDetails(movieId));
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
