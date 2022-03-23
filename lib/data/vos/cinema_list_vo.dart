import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'cinema_list_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_CINEMA_LIST_VO, adapterName: 'CinemaListVOAdapter')
class CinemaListVO {
  @HiveField(0)
  List<CinemaVO>? cinemaList;
  CinemaListVO({
    this.cinemaList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CinemaListVO &&
      listEquals(other.cinemaList, cinemaList);
  }

  @override
  int get hashCode => cinemaList.hashCode;
}
