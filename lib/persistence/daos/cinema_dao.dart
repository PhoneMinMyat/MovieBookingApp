import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() {
    return _singleton;
  }

  CinemaDao._internal();

  void saveCinemaList(CinemaListVO cinemaList, String date) async {
    await getCinemaBox().put(date, cinemaList);
  }

  CinemaListVO getCinemaListByDate(String date) {
    CinemaListVO cinemaListVO = getCinemaBox().get(date) ?? CinemaListVO();
    if (cinemaListVO.cinemaList!.isNotEmpty) {
      return cinemaListVO;
    } else {
      return CinemaListVO();
    }
  }

  //Reactive
  Stream<void> getCinemaListEventStream() {
    return getCinemaBox().watch();
  }

  Stream<CinemaListVO> getCinemaListStream(String date) {
    return Stream.value(getCinemaListByDate(date));
  }

  Box<CinemaListVO> getCinemaBox() {
    return Hive.box<CinemaListVO>(BOX_NAME_CINEMA_LIST_VO);
  }
}
