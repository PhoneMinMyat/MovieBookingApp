import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';

import '../../mock_data/mock_data.dart';

class TmbaModelImplMock extends TmbaModel {
  @override
  void deleteAllProfileFromDatabase() {
    // no need to mock
  }

  @override
  void getCinemaDayTimeslot(String movieId, String date) {
    // no need to mock
  }

  @override
  Stream<CinemaListVO?> getCinemaDayTimeslotFromDatabase(
      String date, String movieId) {
    return Stream.value(getMockCinemaListVO());
  }

  @override
  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      String cinemaDayTimeslotId, String bookingDate) {
    return Future.value(getMockMovieSeatList()?.first);
  }

  @override
  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase() {
    return Stream.value(getMockPaymentMethodList());
  }

  @override
  Future<void> getProfile() {
    // no need to mock
    return Future.value(null);
  }

  @override
  Stream<ProfileVO> getProfileFromDatabase() {
    return Stream.value(getMockProfile() ?? ProfileVO());
  }

  @override
  void getSnackList() {
    // no need to mock
  }

  @override
  Stream<List<SnackVO>?> getSnackListFromDatabase() {
    return Stream.value(getMockSnackList());
  }

  @override
  Future<CheckoutVO?> postCheckout(CheckOutRequest checkOutRequest) {
    return Future.value(getMockCheckOut());
  }

  @override
  Future<List<CardVO>?> postCreateCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(getMockCardList());
  }

  @override
  Future<ProfileVO> postLogInWithFacebook(String token) {
    return Future.value(getMockProfile());
  }

  @override
  Future<ProfileVO> postLogInWithGmail(String email, String password) {
    return Future.value(getMockProfile());
  }

  @override
  Future<ProfileVO> postLogInWithGoogle(String token) {
    return Future.value(getMockProfile());
  }

  @override
  Future<int> postLogOut() {
    return Future.value(getMockGetLogInResponse().code);
  }

  @override
  Future<ProfileVO> postRegisterData(String name, String email, String phone,
      String password, String googleAccessToken, String fbAccessToken) {
    return Future.value(getMockProfile());
  }
}
