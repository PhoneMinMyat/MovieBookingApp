// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentMethodResponse _$GetPaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentMethodResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentMethodVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPaymentMethodResponseToJson(
        GetPaymentMethodResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
