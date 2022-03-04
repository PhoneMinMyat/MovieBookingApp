// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutVO _$CheckoutVOFromJson(Map<String, dynamic> json) => CheckoutVO(
      id: json['id'] as int?,
      bookingNo: json['booking_no'] as String?,
      bookingDate: json['booking_date'] as String?,
      row: json['row'] as String?,
      seat: json['seat'] as String?,
      totalSeat: json['total_seat'] as int?,
      total: json['total'] as String?,
      movieId: json['movie_id'] as int?,
      cinemaId: json['cinema_id'] as int?,
      username: json['username'] as String?,
      timeslot: json['timeslot'] == null
          ? null
          : TimeslotsVO.fromJson(json['timeslot'] as Map<String, dynamic>),
      snacks: (json['snacks'] as List<dynamic>?)
          ?.map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      qrCode: json['qr_code'] as String?,
    );

Map<String, dynamic> _$CheckoutVOToJson(CheckoutVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'booking_date': instance.bookingDate,
      'row': instance.row,
      'seat': instance.seat,
      'total_seat': instance.totalSeat,
      'total': instance.total,
      'movie_id': instance.movieId,
      'cinema_id': instance.cinemaId,
      'username': instance.username,
      'timeslot': instance.timeslot,
      'snacks': instance.snacks,
      'qr_code': instance.qrCode,
    };
