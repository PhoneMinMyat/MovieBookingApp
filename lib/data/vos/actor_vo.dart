import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: 'ActorVOAdapter')
class ActorVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;

  @JsonKey(name: 'gender')
  @HiveField(1)
  int? gender;

  @JsonKey(name: 'id')
  @HiveField(2)
  int? id;

  @JsonKey(name: 'known_for')
  @HiveField(3)
  List<MovieVO>? knownFor;

  @JsonKey(name: 'known_for_department')
  @HiveField(4)
  String? knownForDepartment;

  @JsonKey(name: 'name')
  @HiveField(5)
  String? name;

  @JsonKey(name: 'popularity')
  @HiveField(6)
  double? popularity;

  @JsonKey(name: 'profile_path')
  @HiveField(7)
  String? profilePath;

  @JsonKey(name: 'original_name')
  @HiveField(8)
  String? originalName;

  @JsonKey(name: 'cast_id')
  @HiveField(9)
  int? castId;

  @JsonKey(name: 'character')
  @HiveField(10)
  String? character;

  @JsonKey(name: 'credit_id')
  @HiveField(11)
  String? creditId;

  @JsonKey(name: 'order')
  @HiveField(12)
  int? order;
  ActorVO({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
    this.originalName,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);

  @override
  String toString() {
    return 'ActorVO(adult: $adult, gender: $gender, id: $id, knownFor: $knownFor, knownForDepartment: $knownForDepartment, name: $name, popularity: $popularity, profilePath: $profilePath, originalName: $originalName, castId: $castId, character: $character, creditId: $creditId, order: $order)';
  }

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActorVO &&
      other.adult == adult &&
      other.gender == gender &&
      other.id == id &&
      listEquals(other.knownFor, knownFor) &&
      other.knownForDepartment == knownForDepartment &&
      other.name == name &&
      other.popularity == popularity &&
      other.profilePath == profilePath &&
      other.originalName == originalName &&
      other.castId == castId &&
      other.character == character &&
      other.creditId == creditId &&
      other.order == order;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
      gender.hashCode ^
      id.hashCode ^
      knownFor.hashCode ^
      knownForDepartment.hashCode ^
      name.hashCode ^
      popularity.hashCode ^
      profilePath.hashCode ^
      originalName.hashCode ^
      castId.hashCode ^
      character.hashCode ^
      creditId.hashCode ^
      order.hashCode;
  }
}
