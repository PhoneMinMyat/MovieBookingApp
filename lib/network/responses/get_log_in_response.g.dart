// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_log_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLogInResponse _$GetLogInResponseFromJson(Map<String, dynamic> json) =>
    GetLogInResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProfileVO.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$GetLogInResponseToJson(GetLogInResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
