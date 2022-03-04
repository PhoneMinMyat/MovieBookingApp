import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'timeslots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIMESLOTS_VO, adapterName: 'TimeslotsVOAdapter')
class TimeslotsVO {
  @JsonKey(name: 'cinema_day_timeslot_id')
  @HiveField(0)
  int? cinemaDayTimeSlotId;

  @JsonKey(name: 'start_time')
  @HiveField(1)
  String? startTime;

  @HiveField(2)
  bool? isSelected;

  TimeslotsVO({
    this.cinemaDayTimeSlotId,
    this.startTime,
    this.isSelected,
  });

  void selectHandler() {
    if (isSelected != null) {
      if (isSelected == true) {
        isSelected = false;
      } else {
        isSelected = true;
      }
    }
  }

  factory TimeslotsVO.fromJson(Map<String, dynamic> json) =>
      _$TimeslotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeslotsVOToJson(this);
}
