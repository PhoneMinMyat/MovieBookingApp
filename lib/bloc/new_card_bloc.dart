import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';

class NewCardBloc extends ChangeNotifier {
  TmbaModel _tmbaModel = TmbaModelImpl();

  NewCardBloc([TmbaModel? tmbaModel]) {
    if (tmbaModel != null) {
      _tmbaModel = tmbaModel;
    }
  }
  Future<List<CardVO>?> createCard(
      {required String cardNumber,
      required String cardHolder,
      required String expiration,
      required String cvc}) {
    return _tmbaModel.postCreateCard(cardNumber, cardHolder, expiration, cvc);
  }

  Future<void> getProfile() {
   return _tmbaModel.getProfile();
  }
}
