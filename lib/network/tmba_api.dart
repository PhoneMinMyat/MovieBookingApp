import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_seating_plan_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_day_timeslot_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_list_response.dart';
import 'package:retrofit/http.dart';
import 'package:movie_booking_app/network/responses/get_log_in_response.dart';
import 'package:movie_booking_app/network/responses/get_payment_method_response.dart';
import 'package:movie_booking_app/network/responses/get_create_card_response.dart';

part 'tmba_api.g.dart';

@RestApi(baseUrl: BASE_TMBA_URL_DIO)
abstract class TmbaApi {
  factory TmbaApi(Dio dio) = _TmbaApi;

  @POST(ENDPOINTS_POST_REGISTER)
  @FormUrlEncoded()
  Future<GetLogInResponse> postRegister(
    @Field(PARAM_NAME) String name,
    @Field(PARAM_EMAIL) String email,
    @Field(PARAM_PHONE) String phone,
    @Field(PARAM_PASSWORD) String password,
    @Field(PARAM_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
    @Field(PARAM_FACEBOOK_ACCESS_TOKEN) String fbAccessToken,
  );

  @POST(ENDPOINTS_POST_LOGIN_WITH_EMAIL)
  @FormUrlEncoded()
  Future<GetLogInResponse> postLogInWithEmail(
    @Field(PARAM_EMAIL) String email,
    @Field(PARAM_PASSWORD) String password,
  );

  @POST(ENDPOINTS_POST_LOGIN_WITH_GOOGLE)
  @FormUrlEncoded()
  Future<GetLogInResponse> postLogInWithGoogle(
    @Field(PARAM_ACCESS_TOKEN) String accessToken,
  );

  @POST(ENDPOINTS_POST_LOGIN_WITH_FACEBOOK)
  @FormUrlEncoded()
  Future<GetLogInResponse> postLogInWithFacebook(
    @Field(PARAM_ACCESS_TOKEN) String accessToken,
  );

  @POST(ENDPOINTS_LOG_OUT)
  Future<GetLogInResponse> postLogOut(
      @Header(PARAM_AUTHORIZATION) String token);

  @GET(ENDPOINTS_GET_CINEMA_TIMESLOT)
  Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeslot(
    @Header(PARAM_AUTHORIZATION) String token,
    @Query(PARAM_MOVIE_ID) String movieId,
    @Query(PARAM_DATE) String date,
  );

  @GET(ENDPOINTS_CINEMA_SEATING_PLAN)
  Future<GetCinemaSeatingPlanResponse> getCinemaSeatingPlan(
    @Header(PARAM_AUTHORIZATION) String token,
    @Query(PARAM_CINEMA_DAY_TIMESLOT_ID) String cinemaDayTimeslotId,
    @Query(PARAM_BOOKING_DATE) String date,
  );

  @GET(ENDPOINTS_GET_SNACK_LIST)
  Future<GetSnackListResponse> getSnackList(
    @Header(PARAM_AUTHORIZATION) String token,
  );

  @GET(ENDPOINTS_GET_PAYMENT_METHOD)
  Future<GetPaymentMethodResponse> getPaymentMethodList(
@Header(PARAM_AUTHORIZATION) String token,
  );

  @GET(ENDPOINTS_GET_PROFILE)
  Future<GetLogInResponse> getProfile(
    @Header(PARAM_AUTHORIZATION) String token,
  );

  @POST(ENDPOINTS_POST_CREATE_CARD)
  @FormUrlEncoded()
  Future<GetCreateCardResponse> postCreateCard(
    @Header(PARAM_AUTHORIZATION) String token,
    @Field(PARAM_CARD_NUMBER) String cardNumber,
    @Field(PARAM_CARD_HOLDER) String cardHolder,
    @Field(PARAM_EXPIRATION_DATE) String expirationDate,
    @Field(PARAM_CVC) String cvc,
  );

  @POST(ENDPOINTS_CHECKOUT)
  Future<CheckoutResponse> postCheckout(
    @Header(PARAM_AUTHORIZATION) String token,
    @Body() CheckOutRequest checkOutRequest,
  );

}
