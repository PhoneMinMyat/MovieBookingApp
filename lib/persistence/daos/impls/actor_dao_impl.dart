import 'package:hive/hive.dart';
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
  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActors() {
    List<ActorVO> actorList = getActorBox().values.toList();
    if (actorList.isNotEmpty) {
      return actorList;
    } else {
      return [];
    }
  }

  //Reactive
  @override
  Stream<void> getActorsEventStream() {
    return getActorBox().watch();
  }

  @override
  Stream<List<ActorVO>> getActorsStream() {
    return Stream.value(getAllActors());
  }


  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }
}
