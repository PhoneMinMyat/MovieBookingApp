import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDao {
  Map<int, ActorVO> actorListFromDataBaseMock = {};

  @override
  Stream<void> getActorsEventStream() {
    return Stream.value(null);
  }

  @override
  void saveAllActors(List<ActorVO> actorList, movieId) {
    actorList.forEach((actor) {
      actorListFromDataBaseMock[actor.id ?? 0] = actor;
    });
  }

  @override
  List<ActorVO> getActorsByMovieId(int movieId) {
    return actorListFromDataBaseMock.values.toList();
  }

  @override
  Stream<List<ActorVO>> getActorsByMovieIdStream(int movieId) {
    return Stream.value(getMockActors() ?? []);
  }
}
