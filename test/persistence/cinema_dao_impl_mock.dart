import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/persistence/daos/cinema_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaDaoImplMock extends CinemaDao {
  Map<String, CinemaListVO> cinemaListFromDataBaseMock = {};
  @override
  CinemaListVO getCinemaListByDate(String date) {
    return getMockCinemaListVO() ?? CinemaListVO();
  }

  @override
  Stream<void> getCinemaListEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<CinemaListVO> getCinemaListStream(String date) {
    return Stream.value(getMockCinemaListVO() ?? CinemaListVO());
  }

  @override
  void saveCinemaList(CinemaListVO cinemaList, String date) {
    cinemaListFromDataBaseMock[date] = cinemaList;
  }
}
