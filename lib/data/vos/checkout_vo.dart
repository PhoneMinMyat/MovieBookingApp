import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';

part 'checkout_vo.g.dart';

@JsonSerializable()
class CheckoutVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'booking_no')
  String? bookingNo;

  @JsonKey(name: 'booking_date')
  String? bookingDate;

  @JsonKey(name: 'row')
  String? row;

  @JsonKey(name: 'seat')
  String? seat;

  @JsonKey(name: 'total_seat')
  int? totalSeat;

  @JsonKey(name: 'total')
  String? total;

  @JsonKey(name: 'movie_id')
  int? movieId;

  @JsonKey(name: 'cinema_id')
  int? cinemaId;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'timeslot')
  TimeslotsVO? timeslot;

  @JsonKey(name: 'snacks')
  List<SnackVO>? snacks;

  @JsonKey(name: 'qr_code')
  String? qrCode;

  CheckoutVO({
    this.id,
    this.bookingNo,
    this.bookingDate,
    this.row,
    this.seat,
    this.totalSeat,
    this.total,
    this.movieId,
    this.cinemaId,
    this.username,
    this.timeslot,
    this.snacks,
    this.qrCode,
  });

  factory CheckoutVO.fromJson(Map<String, dynamic> json) => _$CheckoutVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutVOToJson(this);

  @override
  String toString() {
    return 'CheckoutVO(id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, username: $username, timeslot: $timeslot, snacks: $snacks, qrCode: $qrCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckoutVO &&
      other.id == id &&
      other.bookingNo == bookingNo &&
      other.bookingDate == bookingDate &&
      other.row == row &&
      other.seat == seat &&
      other.totalSeat == totalSeat &&
      other.total == total &&
      other.movieId == movieId &&
      other.cinemaId == cinemaId &&
      other.username == username &&
      other.timeslot == timeslot &&
      listEquals(other.snacks, snacks) &&
      other.qrCode == qrCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      bookingNo.hashCode ^
      bookingDate.hashCode ^
      row.hashCode ^
      seat.hashCode ^
      totalSeat.hashCode ^
      total.hashCode ^
      movieId.hashCode ^
      cinemaId.hashCode ^
      username.hashCode ^
      timeslot.hashCode ^
      snacks.hashCode ^
      qrCode.hashCode;
  }
}
