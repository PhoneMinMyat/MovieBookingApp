import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';

import 'package:movie_booking_app/data/vos/profile_vo.dart';

part 'get_log_in_response.g.dart';

@JsonSerializable()
class GetLogInResponse {

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  ProfileVO? data;

  @JsonKey(name: 'token')
  String? token;
  

  GetLogInResponse({
    this.code,
    this.message,
    this.data,
    this.token,
  });

  factory GetLogInResponse.fromJson(Map<String, dynamic> json) => _$GetLogInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLogInResponseToJson(this);
}
