import 'package:movie_booking_app/data/vos/actor_vo.dart';

abstract class ActorDao {
  void saveAllActors(List<ActorVO> actorList, int movieId);

  List<ActorVO> getActorsByMovieId(int movieId);

  //Reactive
  Stream<void> getActorsEventStream();

  Stream<List<ActorVO>> getActorsByMovieIdStream(int movieId);
}
