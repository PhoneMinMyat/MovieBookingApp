import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model_impl.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class HomeBloc extends ChangeNotifier {

  //Variables
 bool isDispose = false;

  //STATE VARIABLE
  ProfileVO? profile;
  List<MovieVO>? nowPlayingMovieList;
  List<MovieVO>? upcomingMovieList;

   TheMovieDbModel _model = TheMovieDbModelImpl();
   TmbaModel _tmbaModel = TmbaModelImpl();

  HomeBloc([TheMovieDbModel? movieDbModel, TmbaModel? tmbaModel]) {
    if(movieDbModel != null && tmbaModel != null){
      _model = movieDbModel;
      _tmbaModel = tmbaModel;
    }
    //Profile
    _tmbaModel.getProfileFromDatabase().listen((profileFromDB) {
      profile = profileFromDB;
      safeNotifyListeners();
    }).onError((error) => print(error.toString()));

    //Now Playing
    _model.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovieList = movieList;
      safeNotifyListeners();
    }).onError((error) => print(error.toString()));

    //Upcoming
    _model.getUpcomingMoviesFromDatabase().listen((movieList) {
      upcomingMovieList = movieList;
      safeNotifyListeners();
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

  void safeNotifyListeners(){
    if(isDispose == false){
      notifyListeners();
    }
  }

  void makeDispose(){
    if(isDispose == false){
      isDispose = true;
    }
  }
}
