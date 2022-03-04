
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/card_vo.dart';

part 'get_create_card_response.g.dart';

@JsonSerializable()
class GetCreateCardResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<CardVO>? data;
  GetCreateCardResponse({
    this.code,
    this.message,
    this.data,
  });

  factory GetCreateCardResponse.fromJson(Map<String, dynamic> json) => _$GetCreateCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreateCardResponseToJson(this);
}
