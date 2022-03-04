import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/get_credit_by_movie_responses.dart';
import 'package:movie_booking_app/network/responses/get_genres_responses.dart';
import 'package:movie_booking_app/network/responses/movie_list_responses.dart';
import 'package:retrofit/http.dart';

part 'the_movie_db_api.g.dart';

@RestApi(baseUrl: BASE_MOVIE_DB_URL_DIO)
abstract class TheMovieDbApi {
  factory TheMovieDbApi(Dio dio) = _TheMovieDbApi;

  @GET(ENDPOINTS_GET_NOW_PLAYING)
  Future<MovieListResponses> getNowPlayingMoviesData(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page);

  @GET(ENDPOINTS_GET_UPCOMING)
  Future<MovieListResponses> getUpcomingMoviesData(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page);

  @GET(ENDPOINTS_GET_GENRES)
  Future<GetGenresResponses> getGenreData(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

  @GET('$ENDPOINTS_GET_MOVIE_DETAILS/{movie_id}')
  Future<MovieVO> getMovieDetails(
    @Path('movie_id') String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );

   @GET('/3/movie/{movie_id}/credits')
  Future<GetCreditByMovieResponses> getCreditByMovie(
    @Path('movie_id') String movieId,
    @Query(PARAM_API_KEY) String apiKey,
  );


}
