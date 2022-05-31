import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/actor_list_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class ActorDaoImpl extends ActorDao {
  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() {
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  void saveAllActors(List<ActorVO> actorList, int movieId) async {
    ActorListVO tempActorList = ActorListVO(actorList: actorList);
    getActorBox().put(movieId, tempActorList);
  }

  @override
  List<ActorVO> getActorsByMovieId(int movieId) {
    ActorListVO tempActorList =
        getActorBox().get(movieId) ?? ActorListVO(actorList: []);
    return tempActorList.actorList ?? [];
  }

  //Reactive
  @override
  Stream<void> getActorsEventStream() {
    return getActorBox().watch();
  }

  @override
  Stream<List<ActorVO>> getActorsByMovieIdStream(int movieId) {
    return Stream.value(getActorsByMovieId(movieId));
  }

  Box<ActorListVO> getActorBox() {
    return Hive.box<ActorListVO>(BOX_NAME_ACTOR_LIST_VO);
  }
}
