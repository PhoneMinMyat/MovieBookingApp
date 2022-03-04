import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/data_agents/the_movie_db_data_agent.dart';
import 'package:movie_booking_app/network/the_movie_db_api.dart';

class RetrofiTheMovieDbDataAgentImpl extends TheMovieDbDataAgent {
  late TheMovieDbApi _mApi;

  static final RetrofiTheMovieDbDataAgentImpl _singleton =
      RetrofiTheMovieDbDataAgentImpl._internal();

  factory RetrofiTheMovieDbDataAgentImpl() {
    return _singleton;
  }

  RetrofiTheMovieDbDataAgentImpl._internal() {
    final dio = Dio();
    _mApi = TheMovieDbApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
    return _mApi
        .getNowPlayingMoviesData(API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getUpcomingMovies() {
    return _mApi
        .getUpcomingMoviesData(API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId) {
    return _mApi
        .getCreditByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _mApi.getMovieDetails(movieId.toString(), API_KEY);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _mApi
        .getGenreData(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }
}
