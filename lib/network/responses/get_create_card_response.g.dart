// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_create_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreateCardResponse _$GetCreateCardResponseFromJson(
        Map<String, dynamic> json) =>
    GetCreateCardResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCreateCardResponseToJson(
        GetCreateCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
