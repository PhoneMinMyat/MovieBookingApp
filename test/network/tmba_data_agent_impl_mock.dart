import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/network/data_agents/tmba_data_agent.dart';
import 'package:movie_booking_app/network/responses/get_log_in_response.dart';

import '../mock_data/mock_data.dart';

class TmbaDataAgentImplMock extends TmbaDataAgent{
  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String token, String movieId, String date) {
    return Future.value(getMockCinemaVOList());
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(String token, String cinemaDayTimeslotId, String date) {
    return Future.value(getMockMovieSeatList());
  }

  @override
  Future<List<PaymentMethodVO>?> getPaymentMethodList(String token) {
    return Future.value(getMockPaymentMethodList());
  }

  @override
  Future<ProfileVO> getProfile(String token) {
   return Future.value(getMockProfile());
  }

  @override
  Future<List<SnackVO>?> getSnackList(String token) {
   return Future.value(getMockSnackList());
  }

  @override
  Future<CheckoutVO?> postCheckout(String token, CheckOutRequest checkOutRequest) {
   return Future.value(getMockCheckOut());
  }

  @override
  Future<List<CardVO>?> postCreateCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
   return Future.value(getMockCardList());
  }

  @override
  Future<ProfileVO> postLogInWithEmail(String email, String password) {
    return Future.value(getMockProfile());
  }

  @override
  Future<ProfileVO> postLogInWithGoogle(String token) {
    return Future.value(getMockProfile());
  }

  @override
  Future<GetLogInResponse> postLogOut(String token) {
    return Future.value(getMockGetLogInResponse());
  }

  @override
  Future<ProfileVO> postLoginWIthFacebook(String token) {
   return Future.value(getMockProfile());
  }

  @override
  Future<ProfileVO> postRegisterData(String name, String email, String phone, String password, String googleAccessToken, String fbAccessToken) {
    return Future.value(getMockProfile());
  }

}