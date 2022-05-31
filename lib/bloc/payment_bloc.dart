import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class PaymentBloc extends ChangeNotifier {
  //movie model
  TmbaModel _tmbaModel = TmbaModelImpl();

  //Requets Obj
  CheckOutRequest checkOutRequest = CheckOutRequest();

  //Variable
  int selectedCardIndex = 0;
  bool isDispose = false;

  CheckoutVO? checkoutInfo;

  //State Variables
  ProfileVO? profile;
  List<CardVO>? cardList;

  PaymentBloc(CheckOutRequest checkOutReq, [TmbaModel? tmbaModel]) {
    if (tmbaModel != null) {
      _tmbaModel = tmbaModel;
    }
    _tmbaModel.getProfile();
    //Database
    _tmbaModel.getProfileFromDatabase().listen((profileFromDB) {
      profile = profileFromDB;
      if (profile?.cards?.isNotEmpty ?? false) {
        profile?.makeCardUnselected();
        profile?.cards?.last.isSelected = true;
        cardList = profile?.cards;
        checkOutReq.cardId = cardList?.last.id ?? 0;
        checkOutRequest = checkOutReq;
      }

      safeNotifyListeners();
    }).onError((error) => print(error));
  }

  void onTapCard(int cardId) {
    print('card Id ==== > $cardId');
    List<CardVO> tempCardList = cardList?.map((card) {
          CardVO tempCard = card;
          tempCard.isSelected = false;
          return tempCard;
        }).toList() ??
        [];
    for (var card in tempCardList) {
      if (card.id == cardId) {
        card.isSelected = true;
        print('card number ==== > ${card.cardNumber}');
      }
    }

    cardList = tempCardList;
    checkOutRequest.cardId = cardId;
    print('checkOutReq Id ==== > ${checkOutRequest.cardId}');
    safeNotifyListeners();
  }

  void changeCard(int newIndex) {
    selectedCardIndex = newIndex;

    checkOutRequest.cardId = profile?.cards?[selectedCardIndex].id ?? 0;

    print('card id===> ${profile?.cards?[selectedCardIndex].id}');
    print('card number===> ${profile?.cards?[selectedCardIndex].cardNumber}');
  }

  Future<CheckoutVO?> checkout() {
    checkOutRequest.cardId = profile?.cards?[selectedCardIndex].id ?? 0;
    return _tmbaModel.postCheckout(checkOutRequest);
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

  void makeRun() {
    if (isDispose == true) {
      isDispose = false;
    }
  }
}
