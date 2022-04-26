import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/persistence/daos/snack_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class SnackDaoImpl extends SnackDao {
  static final SnackDaoImpl _sigleton = SnackDaoImpl._internal();

  factory SnackDaoImpl() {
    return _sigleton;
  }

  SnackDaoImpl._internal();

  @override
  void saveSnackList(List<SnackVO> snackList) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);

    await getSnackBox().putAll(snackMap);
  }

  @override
  List<SnackVO> getAllSnacks() {
    List<SnackVO> snackList = getSnackBox().values.toList();
    if (snackList.isNotEmpty) {
      return snackList;
    } else {
      return [];
    }
  }

  //Reactive
  @override
  Stream<void> getSnackListEventStream() {
    return getSnackBox().watch();
  }

  @override
  Stream<List<SnackVO>> getSnackListStream() {
    return Stream.value(getAllSnacks());
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
}
