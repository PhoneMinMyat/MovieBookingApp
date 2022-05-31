import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'actor_list_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_ACTOR_LIST_VO, adapterName: 'ActorListVOAdapter')
class ActorListVO {
  @HiveField(0)
  List<ActorVO>? actorList;
  ActorListVO({
    this.actorList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActorListVO &&
      listEquals(other.actorList, actorList);
  }

  @override
  int get hashCode => actorList.hashCode;
}
