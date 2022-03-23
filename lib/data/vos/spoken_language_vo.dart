import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'spoken_language_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SPOKEN_LANGUAGE_VO, adapterName: 'SpokenLanguageVOAdapter')
class SpokenLanguageVO {
  @JsonKey(name: 'english_name')
  @HiveField(0)
  String? englishName;

  @JsonKey(name: 'iso_639_1')
  @HiveField(1)
  String? iso6391;

  @JsonKey(name: 'name')
  @HiveField(2)
  String? name;
  
  SpokenLanguageVO({
    this.englishName,
    this.iso6391,
    this.name,
  });

  

  factory SpokenLanguageVO.fromJson(Map<String, dynamic> json) => _$SpokenLanguageVOFromJson(json);

   Map<String, dynamic> toJson() => _$SpokenLanguageVOToJson(this);

 

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SpokenLanguageVO &&
      other.englishName == englishName &&
      other.iso6391 == iso6391 &&
      other.name == name;
  }

  @override
  int get hashCode => englishName.hashCode ^ iso6391.hashCode ^ name.hashCode;
}
