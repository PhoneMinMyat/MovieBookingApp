import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/payment_method_vo.dart';

part 'get_payment_method_response.g.dart';

@JsonSerializable()
class GetPaymentMethodResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<PaymentMethodVO>? data;
  GetPaymentMethodResponse({
    this.code,
    this.message,
    this.data,
  });
  
  factory GetPaymentMethodResponse.fromJson(Map<String, dynamic> json) => _$GetPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPaymentMethodResponseToJson(this);
  }
