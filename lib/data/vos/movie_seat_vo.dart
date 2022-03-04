import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/utils/constraints.dart';

part 'movie_seat_vo.g.dart';

@JsonSerializable()
class MovieSeatVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'seat_name')
  String? seatName;

  @JsonKey(name: 'symbol')
  String? symbol;

  @JsonKey(name: 'price')
  double? price;

  bool? isSelected;
  MovieSeatVO({
    this.id,
    this.type,
    this.seatName,
    this.symbol,
    this.price,
    this.isSelected,
  });

  factory MovieSeatVO.fromJson(Map<String, dynamic> json) => _$MovieSeatVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSeatVOToJson(this);

  bool isMovieSeatAvailable() {
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken() {
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle() {
    return type == SEAT_TYPE_TEXT;
  }

  bool isMovieSeatEmpty() {
    return type == SEAT_TYPE_EMPTY;
  }
}
