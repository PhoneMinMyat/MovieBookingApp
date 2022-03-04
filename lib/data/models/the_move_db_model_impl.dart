import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/network/data_agents/retrofit_the_movie_db_data_agent_impl.dart';
import 'package:movie_booking_app/network/data_agents/the_movie_db_data_agent.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';
import 'package:movie_booking_app/persistence/daos/genre_dao.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class TheMovieDbModelImpl implements TheMovieDbModel {
  static final TheMovieDbModelImpl _singleton = TheMovieDbModelImpl._internal();

  factory TheMovieDbModelImpl() {
    return _singleton;
  }

  TheMovieDbModelImpl._internal();

  //Daos
  ActorDao mActorDao = ActorDao();
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();

  //Network
  final TheMovieDbDataAgent _mDataAgent = RetrofiTheMovieDbDataAgentImpl();

  @override
  void getNowPlayingMovies() {
    _mDataAgent.getNowPlayingMovies().then((movies) async {
      List<MovieVO>? nowPlayingMovieList = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isUpcoming = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovieList ?? []);
    });
  }

  @override
  void getUpcomingMovies() {
    _mDataAgent.getUpcomingMovies().then((movies) async {
      List<MovieVO>? upcomingMovieList = movies?.map((movie) {
        movie.isUpcoming = true;
        movie.isNowPlaying = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(upcomingMovieList ?? []);
    });
  }

  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId) {
    return _mDataAgent.getCreditsByMovie(movieId).then((actor) {
      mActorDao.saveAllActors(actor ?? []);
      return Future.value(actor);
    });
  }

  @override
  void getMovieDetails(int movieId) {
    _mDataAgent.getMovieDetails(movieId).then((movie) {
      mMovieDao.saveSingleMovie(movie);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _mDataAgent.getGenres().then((genres) {
      mGenreDao.saveAllGenres(genres ?? []);
      return Future.value(genres);
    });
  }

  //Database
  @override
  Future<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId) {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    getMovieDetails(movieId);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getMovieDetailsStream(movieId))
        .map((event) => mMovieDao.getMovieDetails(movieId));
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies();
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getUpcomingMoviesFromDatabase() {
    getUpcomingMovies();
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getUpComingMoviesStream())
        .map((event) => mMovieDao.getUpComingMovies());
  }

  //DAO
  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<String> getGenresById(List<int> idList) {
    return Future.value(
        idList.map((id) => mGenreDao.searchGenreById(id)).join('/'));
  }
}
