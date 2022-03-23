import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'profile_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PROFILE_VO, adapterName: 'ProfileVOAdapter')
class ProfileVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;

  @JsonKey(name: 'email')
  @HiveField(2)
  String? email;

  @JsonKey(name: 'phone')
  @HiveField(3)
  String? phone;

  @JsonKey(name: 'total_expense')
  @HiveField(4)
  double? totalExpense;

  @JsonKey(name: 'profile_image')
  @HiveField(5)
  String? profileImage;

  @HiveField(6)
  String? token;

  @JsonKey(name: 'cards')
  @HiveField(7)
  List<CardVO>? cards;
  ProfileVO({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.totalExpense,
    this.profileImage,
    this.cards,
    this.token,
  });

  factory ProfileVO.fromJson(Map<String, dynamic> json) =>
      _$ProfileVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileVOToJson(this);

  @override
  String toString() {
    return 'ProfileVO(id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, token: $token, cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProfileVO &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.totalExpense == totalExpense &&
      other.profileImage == profileImage &&
      other.token == token &&
      listEquals(other.cards, cards);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      totalExpense.hashCode ^
      profileImage.hashCode ^
      token.hashCode ^
      cards.hashCode;
  }
}
