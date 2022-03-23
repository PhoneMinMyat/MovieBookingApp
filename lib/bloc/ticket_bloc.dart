import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/models/the_move_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

class TicketBloc extends ChangeNotifier {
  //State Variable
  MovieVO? movie;

  final TheMovieDbModel _theMovieDbModel = TheMovieDbModelImpl();

  TicketBloc(int movieId) {
    _theMovieDbModel
        .getMovieDetailsFromDatabase(movieId)
        .listen((movieDetails) {
      movie = movieDetails;
      notifyListeners();
    }).onError((error) => print(error));
  }
}
