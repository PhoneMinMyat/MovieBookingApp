import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO, adapterName: 'CinemaVOAdapter')
class CinemaVO {
  @JsonKey(name: 'cinema_id')
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: 'cinema')
  @HiveField(1)
  String? cinema;

  @JsonKey(name: 'timeslots')
  @HiveField(2)
  List<TimeslotsVO>? timeslots;



  CinemaVO({
    this.cinemaId,
    this.cinema,
    this.timeslots,
  });

  void makeAllTimeslotsChangeNotSelected() {
    List<TimeslotsVO> tempTimeslots = timeslots?.map((timeslot) {
      TimeslotsVO tempTimeslot = timeslot;
      tempTimeslot.isSelected = false;
      return tempTimeslot;
    }).toList() ?? [];
    
    timeslots = tempTimeslots;
  }

  void searhAndSelectTimeslot(int timeslotId) {
    List<TimeslotsVO> tempTimeslots = timeslots?.map((timeslot) {
      TimeslotsVO tempTimeslot = timeslot;
      if(tempTimeslot.cinemaDayTimeSlotId == timeslotId){
        tempTimeslot.isSelected = true;
      }
      return tempTimeslot;
    }).toList() ?? [];
    
    timeslots = tempTimeslots;
  }

  bool checkTimeslotContain(int timeslotId){
    bool status = false;
    timeslots?.forEach((timeslot) {
      if (timeslot.cinemaDayTimeSlotId == timeslotId) {
        status = true;
      }
    });
    return status;
  }

  
  
  factory CinemaVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CinemaVO &&
      other.cinemaId == cinemaId &&
      other.cinema == cinema &&
      listEquals(other.timeslots, timeslots);
  }

  @override
  int get hashCode => cinemaId.hashCode ^ cinema.hashCode ^ timeslots.hashCode;
}
