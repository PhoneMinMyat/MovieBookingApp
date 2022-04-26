import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';

abstract class ActorDao {
  void saveAllActors(List<ActorVO> actorList) ;

  List<ActorVO> getAllActors();

  //Reactive
  Stream<void> getActorsEventStream();

  Stream<List<ActorVO>> getActorsStream() ;

 
}
