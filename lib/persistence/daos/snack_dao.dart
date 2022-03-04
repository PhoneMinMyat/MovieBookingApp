import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class SnackDao {
  static final SnackDao _sigleton = SnackDao._internal();

  factory SnackDao() {
    return _sigleton;
  }

  SnackDao._internal();

  void saveSnackList(List<SnackVO> snackList) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);

    await getSnackBox().putAll(snackMap);
  }

  List<SnackVO> getAllSnacks() {
    List<SnackVO> snackList = getSnackBox().values.toList();
    if (snackList.isNotEmpty) {
      return snackList;
    } else {
      return [];
    }
  }

  //Reactive
  Stream<void> getSnackListEventStream() {
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>> getSnackListStream() {
    return Stream.value(getAllSnacks());
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
}
