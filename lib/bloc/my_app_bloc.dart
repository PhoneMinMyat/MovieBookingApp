import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class MyAppBloc extends ChangeNotifier {
  //State Variable
  ProfileVO? userProfile;

  TmbaModel _model = TmbaModelImpl();

  MyAppBloc([TmbaModel? tmbaModel]) {
    if (tmbaModel != null) {
      _model = tmbaModel;
    }
    _model.getProfileFromDatabase().listen((profile) {
      if (profile.token != null) {
        userProfile = profile;
        notifyListeners();
      }
    }).onError((error) {});
  }
}
