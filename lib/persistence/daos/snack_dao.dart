import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';

abstract class SnackDao {
  void saveSnackList(List<SnackVO> snackList);

  List<SnackVO> getAllSnacks();

  //Reactive
  Stream<void> getSnackListEventStream();

  Stream<List<SnackVO>> getSnackListStream();

 
}
