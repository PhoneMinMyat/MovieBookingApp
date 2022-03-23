import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class MyAppBloc extends ChangeNotifier {
  //State Variable
  ProfileVO? userProfile;

  final TmbaModel _model = TmbaModelImpl();

  MyAppBloc() {
    _model.getProfileFromDatabase().listen((profile) {
      userProfile = profile;
      notifyListeners();
    }).onError((error) {});
  }
}
