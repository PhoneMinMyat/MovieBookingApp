import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/network/data_agents/retrofit_tmba_data_agent_impl.dart';
import 'package:movie_booking_app/network/data_agents/tmba_data_agent.dart';
import 'package:movie_booking_app/persistence/daos/cinema_dao.dart';
import 'package:movie_booking_app/persistence/daos/impls/cinema_dao_impl.dart';
import 'package:movie_booking_app/persistence/daos/impls/payment_method_dao_impl.dart';
import 'package:movie_booking_app/persistence/daos/impls/profile_dao_impl.dart';
import 'package:movie_booking_app/persistence/daos/impls/snack_dao_impl.dart';
import 'package:movie_booking_app/persistence/daos/payment_method_dao.dart';
import 'package:movie_booking_app/persistence/daos/profile_dao.dart';
import 'package:movie_booking_app/persistence/daos/snack_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class TmbaModelImpl implements TmbaModel {
  static final TmbaModelImpl _singleton = TmbaModelImpl._internal();

  factory TmbaModelImpl() {
    return _singleton;
  }

  TmbaModelImpl._internal();

  ///Daos
  ProfileDao _mProfileDao = ProfileDaoImpl();
  CinemaDao _mCinemaDao = CinemaDaoImpl();
  SnackDao _mSnackDao = SnackDaoImpl();
  PaymentMethodDao _mPaymentDao = PaymentMethodDaoImpl();

  ///Network
  TmbaDataAgent _tmbaDataAgent = RetrofitTmbaDataAgentImpl();

  //For Testing
  void setDaoAndDataAgent(
      ProfileDao profileDao,
      CinemaDao cinemaDao,
      SnackDao snackDao,
      PaymentMethodDao paymentMethodDao,
      TmbaDataAgent tmbaDataAgent) {
    _mProfileDao = profileDao;
    _mCinemaDao = cinemaDao;
    _mSnackDao = snackDao;
    _mPaymentDao = paymentMethodDao;
    _tmbaDataAgent = tmbaDataAgent;
  }

  String getBearerToken() {
    String userToken = _mProfileDao.getProfile().token ?? '';
    String bearerToken = 'Bearer $userToken';
    return bearerToken;
  }

  int getProfileId() {
    int profileId = _mProfileDao.getProfile().id ?? 0;
    return profileId;
  }

  @override
  Future<ProfileVO> postRegisterData(String name, String email, String phone,
      String password, String googleAccessToken, String fbAccessToken) {
    return _tmbaDataAgent
        .postRegisterData(
            name, email, phone, password, googleAccessToken, fbAccessToken)
        .then((profile) {
      _mProfileDao.saveProfile(profile);
      return Future.value(profile);
    });
  }

  @override
  Future<ProfileVO> postLogInWithGmail(String email, String password) {
    return _tmbaDataAgent.postLogInWithEmail(email, password).then((profile) {
      _mProfileDao.saveProfile(profile);
      return Future.value(profile);
    });
  }

  @override
  Future<void> getProfile() {
  return  _tmbaDataAgent.getProfile(getBearerToken()).then((profile) {
      ProfileVO tempProfile = profile;
      tempProfile.token = _mProfileDao.getProfile().token ?? '';
      print(tempProfile.toString());
      _mProfileDao.saveProfile(tempProfile);
    });
  }

  @override
  Future<ProfileVO> postLogInWithGoogle(String token) {
    return _tmbaDataAgent.postLogInWithGoogle(token).then((profile) {
      _mProfileDao.saveProfile(profile);
      return Future.value(profile);
    });
  }

  @override
  Future<ProfileVO> postLogInWithFacebook(String token) {
    return _tmbaDataAgent.postLoginWIthFacebook(token).then((profile) {
      _mProfileDao.saveProfile(profile);
      return Future.value(profile);
    });
  }

  @override
  Future<int> postLogOut() async {
    int code = 0;

    await _tmbaDataAgent.postLogOut(getBearerToken()).then((response) {
      print(response.code);
      code = response.code ?? 0;
      if (response.code == 200) {
        _mProfileDao.deleteAllProfile();
      }
    });
    print(code);
    return Future.value(code);
  }

  @override
  void getCinemaDayTimeslot(String movieId, String date) {
    _tmbaDataAgent
        .getCinemaDayTimeslot(getBearerToken(), movieId, date)
        .then((cinemaList) {
      List<CinemaVO>? tempCinemaList = cinemaList?.map((cinema) {
        cinema.timeslots?.forEach((times) {
          times.isSelected = false;
        });
        return cinema;
      }).toList();

      CinemaListVO tempCinemaListVO = CinemaListVO(cinemaList: tempCinemaList);
      _mCinemaDao.saveCinemaList(tempCinemaListVO, date);
    });
  }

  @override
  Future<List<MovieSeatVO>?> getCinemaSeatingPlan(
      String cinemaDayTimeslotId, String bookingDate) {
    return _tmbaDataAgent
        .getCinemaSeatingPlan(
            getBearerToken(), cinemaDayTimeslotId, bookingDate)
        .then((seatingList) {
      List<MovieSeatVO>? expandedSeatingList =
          seatingList?.expand((seat) => seat).toList().map((seat) {
        seat.isSelected = false;
        return seat;
      }).toList();
      return Future.value(expandedSeatingList);
    });
  }

  @override
  void getSnackList() {
    _tmbaDataAgent.getSnackList(getBearerToken()).then((snackList) {
      List<SnackVO>? tempSnackList = snackList?.map((snack) {
        snack.quantity = 0;
        return snack;
      }).toList();
      _mSnackDao.saveSnackList(tempSnackList ?? []);
      _tmbaDataAgent.getPaymentMethodList(getBearerToken()).then((paymentList) {
        _mPaymentDao.savePaymentList(paymentList ?? []);
      });
    });
  }

  @override
  Future<List<CardVO>?> postCreateCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return _tmbaDataAgent
        .postCreateCard(
            getBearerToken(), cardNumber, cardHolder, expirationDate, cvc)
        .then((cardList) {
      _mProfileDao.updateCardList(cardList ?? [], getProfileId());
      return Future.value(cardList);
    });
  }

  @override
  Future<CheckoutVO?> postCheckout(CheckOutRequest checkOutRequest) {
    return _tmbaDataAgent.postCheckout(getBearerToken(), checkOutRequest);
  }

  //Database

  @override
  Stream<ProfileVO> getProfileFromDatabase() {
   
    return _mProfileDao
        .getProfileEventStream()
        .startWith(_mProfileDao.getProfileStream())
        .map((event) => _mProfileDao.getProfile());
  }

  @override
  void deleteAllProfileFromDatabase() {
    _mProfileDao.deleteAllProfile();
  }

  @override
  Stream<CinemaListVO?> getCinemaDayTimeslotFromDatabase(
      String date, String movieId) {
    getCinemaDayTimeslot(movieId, date);
    return _mCinemaDao
        .getCinemaListEventStream()
        .startWith(_mCinemaDao.getCinemaListStream(date))
        .map((event) => _mCinemaDao.getCinemaListByDate(date));
  }

  @override
  Stream<List<SnackVO>?> getSnackListFromDatabase() {
    getSnackList();
    return _mSnackDao
        .getSnackListEventStream()
        .startWith(_mSnackDao.getSnackListStream())
        .map((event) => _mSnackDao.getAllSnacks());
  }

  @override
  Stream<List<PaymentMethodVO>?> getPaymentMethodFromDatabase() {
    getSnackList();
    return _mPaymentDao
        .getPaymentMethodEventStream()
        .startWith(_mPaymentDao.getPaymentMethodStream())
        .map((event) => _mPaymentDao.getAllPaymentMethods());
  }
}
