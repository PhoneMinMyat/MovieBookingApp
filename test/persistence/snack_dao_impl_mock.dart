import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/persistence/daos/snack_dao.dart';

import '../mock_data/mock_data.dart';

class SnackDaoImplMock extends SnackDao {
  Map<int, SnackVO> snackListFromDatabaseMock = {};
  @override
  List<SnackVO> getAllSnacks() {
    return getMockSnackList();
  }

  @override
  Stream<void> getSnackListEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<List<SnackVO>> getSnackListStream() {
    return Stream.value(getMockSnackList());
  }

  @override
  void saveSnackList(List<SnackVO> snackList) {
    snackList.forEach((snack) {
      snackListFromDatabaseMock[snack.id ?? 0] = snack;
    });
  }
}
