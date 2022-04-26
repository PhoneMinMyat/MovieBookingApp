import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/persistence/daos/cinema_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class CinemaDaoImpl extends CinemaDao{
  static final CinemaDaoImpl _singleton = CinemaDaoImpl._internal();

  factory CinemaDaoImpl() {
    return _singleton;
  }

  CinemaDaoImpl._internal();

  @override
  void saveCinemaList(CinemaListVO cinemaList, String date) async {
    await getCinemaBox().put(date, cinemaList);
  }

  @override
  CinemaListVO getCinemaListByDate(String date) {
    CinemaListVO cinemaListVO = getCinemaBox().get(date) ?? CinemaListVO();
    if (cinemaListVO.cinemaList?.isNotEmpty ?? false) {
      return cinemaListVO;
    } else {
      return CinemaListVO();
    }
  }

  //Reactive
  @override
  Stream<void> getCinemaListEventStream() {
    return getCinemaBox().watch();
  }

  @override
  Stream<CinemaListVO> getCinemaListStream(String date) {
    return Stream.value(getCinemaListByDate(date));
  }


  Box<CinemaListVO> getCinemaBox() {
    return Hive.box<CinemaListVO>(BOX_NAME_CINEMA_LIST_VO);
  }
}