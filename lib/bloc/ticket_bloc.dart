import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

class TicketBloc extends ChangeNotifier {
  //State Variable
  MovieVO? movie;

  //Variables
  bool isDispose = false;

   TheMovieDbModel _theMovieDbModel = TheMovieDbModelImpl();

  TicketBloc(int movieId, [TheMovieDbModel? movieDbModel]) {
    if(movieDbModel != null){
      _theMovieDbModel = movieDbModel;
    }
    _theMovieDbModel
        .getMovieDetailsFromDatabase(movieId)
        .listen((movieDetails) {
      movie = movieDetails;
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
