// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatVO _$MovieSeatVOFromJson(Map<String, dynamic> json) => MovieSeatVO(
      id: json['id'] as int?,
      type: json['type'] as String?,
      seatName: json['seat_name'] as String?,
      symbol: json['symbol'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$MovieSeatVOToJson(MovieSeatVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
