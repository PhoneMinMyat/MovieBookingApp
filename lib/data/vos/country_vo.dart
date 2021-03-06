import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'country_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COUNTRY_VO,adapterName: 'CountryVOAdapter')
class CountryVO {
  @JsonKey(name: 'iso_3166_1')
   @HiveField(0)
  String? iso3166;

  @JsonKey(name: 'name')
   @HiveField(1)
  String? name;

  CountryVO({
    this.iso3166,
    this.name,
  });

  factory CountryVO.fromJson(Map<String, dynamic> json) =>
      _$CountryVOFromJson(json);

  Map<String, dynamic> toJson() => _$CountryVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CountryVO &&
      other.iso3166 == iso3166 &&
      other.name == name;
  }

  @override
  int get hashCode => iso3166.hashCode ^ name.hashCode;
}
