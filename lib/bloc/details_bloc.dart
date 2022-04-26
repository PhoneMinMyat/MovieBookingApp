import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

class DetailsBloc extends ChangeNotifier {
   TheMovieDbModel _mMovieModel = TheMovieDbModelImpl();

  //Variables
  bool isDispose = false;

  //StateVariable
  MovieVO? movie;
  List<ActorVO>? actorList;

  DetailsBloc(int movieId,[TheMovieDbModel? movieDbModel]) {
    if(movieDbModel != null){
      _mMovieModel = movieDbModel;
    }

    //Movie
    //Database
    _mMovieModel.getMovieDetailsFromDatabase(movieId).listen((movie) {
      this.movie = movie;
      safeNotifyListeners();
    }).onError((error) => print(error));

    //ActorList
    _mMovieModel.getCreditsByMovieFromDatabase(movieId).listen((actorList) {
      this.actorList = actorList;
      safeNotifyListeners();
    }).onError((error) => print(error));
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
