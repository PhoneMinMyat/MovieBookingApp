import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/data_agents/tmba_data_agent.dart';
import 'package:movie_booking_app/network/responses/get_log_in_response.dart';
import 'package:movie_booking_app/network/tmba_api.dart';

class RetrofitTmbaDataAgentImpl extends TmbaDataAgent {
  late TmbaApi _tmbaApi;
  static final RetrofitTmbaDataAgentImpl _singleton =
      RetrofitTmbaDataAgentImpl._internal();

  factory RetrofitTmbaDataAgentImpl() {
    return _singleton;
  }

  RetrofitTmbaDataAgentImpl._internal() {
    final dio = Dio();
    dio.options = BaseOptions(headers: {
      HEADER_ACCEPT: APPLICATION_JSON,
      HEADER_CONTENT_TYPE: APPLICATION_JSON
    });
    _tmbaApi = TmbaApi(dio);
  }

  @override
  Future<ProfileVO> postRegisterData(String name, String email, String phone,
      String password, String googleAccessToken, String fbAccessToken) {
        
    return _tmbaApi
        .postRegister(
            name, email, phone, password, googleAccessToken, fbAccessToken)
        .then((response) {
      print('RESPONSE MESSAGE ====> ${response.message}');
    
      ProfileVO profileVO = response.data ?? ProfileVO();
      profileVO.token = response.token;
      return profileVO;
    });
  }

  @override
  Future<ProfileVO> postLogInWithEmail(String email, String password) {
    return _tmbaApi.postLogInWithEmail(email, password).then((response) {
      print(response.code);
      print(response.message);
      ProfileVO profileVO = response.data ?? ProfileVO();
      profileVO.token = response.token;
      return profileVO;
    });
  }

  @override
  Future<ProfileVO> postLogInWithGoogle(String token) {
    return _tmbaApi.postLogInWithGoogle(token).then((response) {
      ProfileVO profileVO = response.data ?? ProfileVO();
      profileVO.token = response.token;
      return profileVO;
    });
  }

  @override
  Future<ProfileVO> postLoginWIthFacebook(String token) {
    return _tmbaApi.postLogInWithFacebook(token).then((response) {
      ProfileVO profileVO = response.data ?? ProfileVO();
      profileVO.token = response.token;
      return profileVO;
    });
  }

  @override
  Future<GetLogInResponse> postLogOut(String token) {
    return _tmbaApi.postLogOut(token);
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(
      String token, String movieId, String date) {
    return _tmbaApi.getCinemaDayTimeslot(token, movieId, date).then((response) {
      return response.data;
    });
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
      String token, String cinemaDayTimeslotId, String date) {
    return _tmbaApi
        .getCinemaSeatingPlan(token, cinemaDayTimeslotId, date)
        .then((response) {
      return response.data;
    });
  }

  @override
  Future<List<SnackVO>?> getSnackList(String token) {
    return _tmbaApi
        .getSnackList(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<PaymentMethodVO>?> getPaymentMethodList(String token) {
    return _tmbaApi
        .getPaymentMethodList(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<ProfileVO> getProfile(String token) {
    return _tmbaApi.getProfile(token).then((response) {
      ProfileVO profileVO = response.data ?? ProfileVO();
      return profileVO;
    });
  }

  @override
  Future<List<CardVO>?> postCreateCard(String token, String cardNumber,
      String cardHolder, String expirationDate, String cvc) {
    return _tmbaApi
        .postCreateCard(token, cardNumber, cardHolder, expirationDate, cvc)
        .then((response) => response.data);
  }

  @override
  Future<CheckoutVO?> postCheckout(
      String token, CheckOutRequest checkOutRequest) {
    return _tmbaApi
        .postCheckout(token, checkOutRequest)
        .then((response) {
          print('Response Checkout ===> ${response.toString()}');
return response.data;
        } );
  }

  
}
