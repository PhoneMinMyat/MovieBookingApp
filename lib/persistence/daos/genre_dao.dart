import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';

abstract class GenreDao {
  void saveAllGenres(List<GenreVO> genreList);

  List<GenreVO> getAllGenres();

  String searchGenreById(int genreId);

  
}
