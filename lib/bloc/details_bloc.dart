import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/models/the_move_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

class DetailsBloc extends ChangeNotifier {
  final TheMovieDbModel _mMovieModel = TheMovieDbModelImpl();
  //StateVariable
  MovieVO? movie;
  List<ActorVO>? actorList;

  DetailsBloc(int movieId) {
    //Movie
    //Database
    _mMovieModel.getMovieDetailsFromDatabase(movieId).listen((movie) {
      this.movie = movie;
      notifyListeners();
    }).onError((error) => print(error));

    //ActorList
    _mMovieModel.getCreditsByMovieFromDatabase(movieId).listen((actorList) {
      this.actorList = actorList;
      notifyListeners();
    }).onError((error) => print(error));
  }
}
