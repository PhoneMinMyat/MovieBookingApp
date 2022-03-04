// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponses _$MovieListResponsesFromJson(Map<String, dynamic> json) =>
    MovieListResponses(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieListResponsesToJson(MovieListResponses instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
