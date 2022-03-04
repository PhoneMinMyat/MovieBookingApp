// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeslotsVOAdapter extends TypeAdapter<TimeslotsVO> {
  @override
  final int typeId = 11;

  @override
  TimeslotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeslotsVO(
      cinemaDayTimeSlotId: fields[0] as int?,
      startTime: fields[1] as String?,
      isSelected: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeslotsVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaDayTimeSlotId)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeslotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotsVO _$TimeslotsVOFromJson(Map<String, dynamic> json) => TimeslotsVO(
      cinemaDayTimeSlotId: json['cinema_day_timeslot_id'] as int?,
      startTime: json['start_time'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$TimeslotsVOToJson(TimeslotsVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeSlotId,
      'start_time': instance.startTime,
      'isSelected': instance.isSelected,
    };
