// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutRequest _$CheckOutRequestFromJson(Map<String, dynamic> json) =>
    CheckOutRequest(
      cinemaDayTimeslotId: json['cinema_day_timeslot_id'] as int?,
      row: json['row'] as String?,
      seatNumber: json['seat_number'] as String?,
      bookingDate: json['booking_date'] as String?,
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      movieId: json['movie_id'] as int?,
      cardId: json['card_id'] as int?,
      cinemaId: json['cinema_id'] as int?,
      snacks: (json['snacks'] as List<dynamic>?)
          ?.map((e) => SnackRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckOutRequestToJson(CheckOutRequest instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeslotId,
      'row': instance.row,
      'seat_number': instance.seatNumber,
      'booking_date': instance.bookingDate,
      'total_price': instance.totalPrice,
      'movie_id': instance.movieId,
      'card_id': instance.cardId,
      'cinema_id': instance.cinemaId,
      'snacks': instance.snacks,
    };
