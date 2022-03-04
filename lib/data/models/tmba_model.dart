import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';

abstract class TmbaModel {
  //Network
  Future<ProfileVO> postRegisterData(String name, String email, String phone,
      String password, String googleAccessToken, String fbAccessToken);
  Future<ProfileVO> postLogInWithGmail(String email, String password);
  void getProfile();
  Future<ProfileVO> postLogInWithGoogle(String token);
  Future<ProfileVO> postLogInWithFacebook(String token);
  void getCinemaDayTimeslot(String movieId, String date);
  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      String cinemaDayTimeslotId, String bookingDate);
  void getSnackList();
  Future<List<CardVO>?> postCreateCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc);
  Future<CheckoutVO?> postCheckout(CheckOutRequest checkOutRequest);

  Future<int> postLogOut();

  //Database
  Stream<ProfileVO> getProfileFromDatabase();
  void deleteAllProfileFromDatabase();
  Stream<CinemaListVO?> getCinemaDayTimeslotFromDatabase(String date, String movieId);
  Stream<List<SnackVO>?> getSnackListFromDatabase();
  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase();
}
