import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/network/data_agents/the_movie_db_data_agent.dart';

import '../mock_data/mock_data.dart';

class TheMovieDbDataAgentMock extends TheMovieDbDataAgent{
  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId) {
   return Future.value(getMockActors());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenres());
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return Future.value(getMockMovieListForTest()?.first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
      return Future.value(getMockMovieListForTest()
        ?.where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getUpcomingMovies() {
      return Future.value(getMockMovieListForTest()
        ?.where((element) => element.isUpcoming ?? false)
        .toList());
  }

}