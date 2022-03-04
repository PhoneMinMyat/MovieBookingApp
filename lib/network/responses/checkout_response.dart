import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';

part 'checkout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {
  
  @JsonKey(name: 'code')
  int? code;
  
  @JsonKey(name: 'message')
  String? message;
  
  @JsonKey(name: 'data')
  CheckoutVO? data;

  CheckoutResponse({
    this.code,
    this.message,
    this.data,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) => _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
