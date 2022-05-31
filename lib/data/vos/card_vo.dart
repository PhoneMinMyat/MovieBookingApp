import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'card_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CARD_VO, adapterName: 'CardVOAdapter')
class CardVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'card_holder')
  @HiveField(1)
  String? cardHolder;

  @JsonKey(name: 'card_number')
  @HiveField(2)
  String? cardNumber;

  @JsonKey(name: 'expiration_date')
  @HiveField(3)
  String? expirationDate;

  @JsonKey(name: 'card_type')
  @HiveField(4)
  String? cardType;

  bool? isSelected;

  CardVO({
    this.id,
    this.cardHolder,
    this.cardNumber,
    this.expirationDate,
    this.cardType,
    this.isSelected,
  });

  factory CardVO.fromJson(Map<String, dynamic> json) => _$CardVOFromJson(json);

  Map<String, dynamic> toJson() => _$CardVOToJson(this);

  @override
  String toString() {
    return 'CardVO(id: $id, cardHolder: $cardHolder, cardNumber: $cardNumber, expirationDate: $expirationDate, cardType: $cardType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardVO &&
        other.id == id &&
        other.cardHolder == cardHolder &&
        other.cardNumber == cardNumber &&
        other.expirationDate == expirationDate &&
        other.cardType == cardType &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cardHolder.hashCode ^
        cardNumber.hashCode ^
        expirationDate.hashCode ^
        cardType.hashCode ^
        isSelected.hashCode;
  }
}
