import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/models/the_move_db_model_impl.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class HomeBloc extends ChangeNotifier {
  //STATE VARIABLE
  ProfileVO? profile;
  List<MovieVO>? nowPlayingMovieList;
  List<MovieVO>? upcomingMovieList;

  final TheMovieDbModel _model = TheMovieDbModelImpl();
  final TmbaModel _tmbaModel = TmbaModelImpl();

  HomeBloc() {
    //Profile
    _tmbaModel.getProfileFromDatabase().listen((profileFromDB) {
      profile = profileFromDB;
      notifyListeners();
    }).onError((error) => print(error.toString()));

    //Now Playing
    _model.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovieList = movieList;
      notifyListeners();
    }).onError((error) => print(error.toString()));

    //Upcoming
    _model.getUpcomingMoviesFromDatabase().listen((movieList) {
      upcomingMovieList = movieList;
      notifyListeners();
    }).onError((error) => print(error.toString()));

  }

  Future<bool> tabLogOut(){
    bool success = false;
     _tmbaModel.postLogOut().then((code) {
        if (code == 0) {
          success = true;
        }
      }).catchError((error) => print(error));
    return Future.value(success);
  }
}
