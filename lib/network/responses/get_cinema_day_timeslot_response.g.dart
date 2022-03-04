// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_day_timeslot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaDayTimeslotResponse _$GetCinemaDayTimeslotResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaDayTimeslotResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CinemaVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCinemaDayTimeslotResponseToJson(
        GetCinemaDayTimeslotResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
