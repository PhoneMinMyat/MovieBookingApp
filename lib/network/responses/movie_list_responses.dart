import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

part 'movie_list_responses.g.dart';

@JsonSerializable()
class MovieListResponses {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<MovieVO>? results;


  MovieListResponses({
    this.page,
    this.results,
  });

factory MovieListResponses.fromJson(Map<String, dynamic> json) => _$MovieListResponsesFromJson(json);

   Map<String, dynamic> toJson() => _$MovieListResponsesToJson(this);

}
