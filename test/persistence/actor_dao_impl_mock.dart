import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDao{
  Map<int, ActorVO> actorListFromDataBaseMock = {};

  @override
  Stream<void> getActorsEventStream() {
   return Stream.value(null);
  }

  @override
  Stream<List<ActorVO>> getActorsStream() {
    return Stream.value(getMockActors() ?? []);
  }

  @override
  List<ActorVO> getAllActors() {
    return actorListFromDataBaseMock.values.toList();
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    actorList.forEach((actor) { 
     actorListFromDataBaseMock[actor.id ?? 0] = actor;
   });
  }

 

}