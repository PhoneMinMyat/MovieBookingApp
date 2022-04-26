import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';

abstract class CinemaDao {
  void saveCinemaList(CinemaListVO cinemaList, String date);

  CinemaListVO getCinemaListByDate(String date);

  //Reactive
  Stream<void> getCinemaListEventStream();

  Stream<CinemaListVO> getCinemaListStream(String date);

  
}
