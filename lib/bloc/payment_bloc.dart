import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class PaymentBloc extends ChangeNotifier {
  //movie model
  final TmbaModel _tmbaModel = TmbaModelImpl();

  //Requets Obj
  CheckOutRequest checkOutRequest = CheckOutRequest();

  //Variable
  int selectedCardIndex = 0;

  CheckoutVO? checkoutInfo;

  //State Variables
  ProfileVO? profile;

  PaymentBloc(CheckOutRequest checkOutReq) {
    //Database
    _tmbaModel.getProfileFromDatabase().listen((profileFromDB) {
      profile = profileFromDB;
      checkOutReq.cardId = profile?.cards?.first.id ?? 0;
      checkOutRequest = checkOutReq;
      notifyListeners();
    }).onError((error) => print(error));
  }

  void changeCard(int newIndex) {
    selectedCardIndex = newIndex;
    checkOutRequest.cardId = profile?.cards?[selectedCardIndex].id ?? 0;
  }

  Future<CheckoutVO?> checkout() {
    checkOutRequest.cardId = profile?.cards?[selectedCardIndex].id ?? 0;
    return _tmbaModel.postCheckout(checkOutRequest);
  }
}
