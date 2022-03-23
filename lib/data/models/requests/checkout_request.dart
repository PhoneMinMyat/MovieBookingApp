import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/models/requests/snack_request.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckOutRequest {
  @JsonKey(name: 'cinema_day_timeslot_id')
  int? cinemaDayTimeslotId;
  
  @JsonKey(name: 'row')
  String? row;
  
  @JsonKey(name: 'seat_number')
  String? seatNumber;
  
  @JsonKey(name: 'booking_date')
  String? bookingDate;
  
  @JsonKey(name: 'total_price')
  double? totalPrice;
  
  @JsonKey(name: 'movie_id')
  int? movieId;
  
  @JsonKey(name: 'card_id')
  int? cardId;
  
  @JsonKey(name: 'cinema_id')
  int? cinemaId;
  
  @JsonKey(name: 'snacks')
  List<SnackRequest>? snacks;

  CheckOutRequest({
    this.cinemaDayTimeslotId,
    this.row,
    this.seatNumber,
    this.bookingDate,
    this.totalPrice,
    this.movieId,
    this.cardId,
    this.cinemaId,
    this.snacks,
  });

  factory CheckOutRequest.fromJson(Map<String, dynamic> json) => _$CheckOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);

  @override
  String toString() {
    return 'CheckOutRequest(cinemaDayTimeslotId: $cinemaDayTimeslotId, row: $row, seatNumber: $seatNumber, bookingDate: $bookingDate, totalPrice: $totalPrice, movieId: $movieId, cardId: $cardId, cinemaId: $cinemaId, snacks: ${snacks.toString()})';
  }
}
