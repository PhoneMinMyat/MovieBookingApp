import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';

class SnackBloc extends ChangeNotifier {
  //Variables
  bool isDispose = false;

  //Model
  TmbaModel _tmbaModel = TmbaModelImpl();

  //State Variables
  List<SnackVO>? snackList;
  List<PaymentMethodVO>? paymentMethodList;
  double totalPrice = 0;

  SnackBloc([TmbaModel? tmbaModel]) {
    if (tmbaModel != null) {
      _tmbaModel = tmbaModel;
    }
    //Snack
    _tmbaModel.getSnackListFromDatabase().listen((snackListFromDB) {
      snackList = snackListFromDB;
      safeNotifyListeners();
    }).onError((error) => print(error));

    //PaymentMethod
    _tmbaModel.getPaymentMethodFromDatabase().listen((paymentListFromDB) {
      paymentMethodList = paymentListFromDB;
      safeNotifyListeners();
    }).onError((error) => print(error.toString()));
  }

  void increaseCounter(int snackId) {
    snackList?.firstWhere((snack) => snack.id == snackId).increaseQty();
    safeNotifyListeners();
    getTotalSnackPrice();
  }

  void decreaseCounter(int snackId) {
    snackList?.firstWhere((snack) => snack.id == snackId).decreaseQty();
    safeNotifyListeners();
    getTotalSnackPrice();
  }

  void getTotalSnackPrice() {
    double total = 0;
    snackList?.forEach((snack) {
      total += snack.getTotalPrice();
    });
    totalPrice = total;
    safeNotifyListeners();
  }

  List<SnackVO> getSelectedSnackList() {
    List<SnackVO> selectedSnack =
        snackList?.where((snack) => snack.quantity! > 0).toList() ?? [];

    return selectedSnack;
  }

  void safeNotifyListeners() {
    if (isDispose == false) {
      notifyListeners();
    }
  }

  void makeDispose() {
    if (isDispose == false) {
      isDispose = true;
    }
  }
}
