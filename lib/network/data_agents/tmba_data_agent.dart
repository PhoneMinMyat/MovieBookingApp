import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/network/responses/get_log_in_response.dart';

abstract class TmbaDataAgent {
  Future<ProfileVO> postRegisterData(String name, String email, String phone,
      String password, String googleAccessToken, String fbAccessToken);

  Future<ProfileVO> postLogInWithEmail(String email, String password);

  Future<ProfileVO> getProfile(String token);

  Future<ProfileVO> postLogInWithGoogle(String token);

  Future<ProfileVO> postLoginWIthFacebook(String token);

  Future<GetLogInResponse> postLogOut(String token);

  Future<List<CinemaVO>?> getCinemaDayTimeslot(
      String token, String movieId, String date);
  
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(String token, String cinemaDayTimeslotId, String date);

  Future<List<SnackVO>?> getSnackList(String token);

  Future<List<PaymentMethodVO>?> getPaymentMethodList(String token);

  Future<List<CardVO>?> postCreateCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc);

  Future<CheckoutVO?> postCheckout(String token, CheckOutRequest checkOutRequest);
}
