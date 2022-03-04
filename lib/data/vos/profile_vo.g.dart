// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileVOAdapter extends TypeAdapter<ProfileVO> {
  @override
  final int typeId = 1;

  @override
  ProfileVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileVO(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      totalExpense: fields[4] as double?,
      profileImage: fields[5] as String?,
      cards: (fields[7] as List?)?.cast<CardVO>(),
      token: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.totalExpense)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileVO _$ProfileVOFromJson(Map<String, dynamic> json) => ProfileVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      totalExpense: (json['total_expense'] as num?)?.toDouble(),
      profileImage: json['profile_image'] as String?,
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ProfileVOToJson(ProfileVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
      'token': instance.token,
      'cards': instance.cards,
    };
