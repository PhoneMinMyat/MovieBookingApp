// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_list_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorListVOAdapter extends TypeAdapter<ActorListVO> {
  @override
  final int typeId = 16;

  @override
  ActorListVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActorListVO(
      actorList: (fields[0] as List?)?.cast<ActorVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActorListVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.actorList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorListVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
