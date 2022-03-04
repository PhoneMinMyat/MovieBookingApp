import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/cinema_vo.dart';

part 'get_cinema_day_timeslot_response.g.dart';

@JsonSerializable()
class GetCinemaDayTimeslotResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<CinemaVO>? data;

  GetCinemaDayTimeslotResponse({
    this.code,
    this.message,
    this.data,
  });

  factory GetCinemaDayTimeslotResponse.fromJson(Map<String, dynamic> json) => _$GetCinemaDayTimeslotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCinemaDayTimeslotResponseToJson(this);
}
