import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_booking_app/data/vos/collection_vo.dart';
import 'package:movie_booking_app/data/vos/country_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: 'MovieVOAdapter')
class MovieVO {
  @JsonKey(name: "adult")
   @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
   @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "genre_ids")
   @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
   @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
   @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
   @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
   @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
   @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
   @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
   @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
   @HiveField(10)
  String? title;

  @JsonKey(name: "video")
   @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
   @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
   @HiveField(13)
  int? voteCount;

  @JsonKey(name: 'belongs_to_collection')
   @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: 'budget')
   @HiveField(15)
  double? budget;

  @JsonKey(name: 'genres')
   @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: 'homepage')
   @HiveField(17)
  String? homepage;

  @JsonKey(name: 'imdb_id')
   @HiveField(18)
  String? imdbId;

  @JsonKey(name: 'production_companies')
   @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: 'production_countries')
   @HiveField(20)
  List<CountryVO>? productionCountries;

  @JsonKey(name: 'revenue')
   @HiveField(21)
  double? revenue;

  @JsonKey(name: 'runtime')
   @HiveField(22)
  int? runtime;

  @JsonKey(name: 'spoken_languages')
   @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguage;

  @JsonKey(name: 'status')
   @HiveField(24)
  String? status;

  @JsonKey(name: 'tagline')
   @HiveField(25)
  String? tagLine;

  @HiveField(26)
  bool? isNowPlaying;

   @HiveField(27)
  bool? isUpcoming;

  
  MovieVO({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.imdbId,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runtime,
    this.spokenLanguage,
    this.status,
    this.tagLine,
    this.isNowPlaying,
    this.isUpcoming,
  });

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  String getGenreAsCommaSeparatedString() {
    return getGenreListAsStringList().join(',');
  }
  String getGenreAsSlashSeparatedString() {
    return getGenreListAsStringList().join('/');
  }

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? '').toList() ?? [];
  }

  String getProductionCountryAsCommaSeparatedString() {
    return productionCountries
            ?.map((country) => country.name)
            .toList()
            .join(',') ??
        '';
  }

   String getProductionCompanyAsCommaSeparatedString() {
    return productionCompanies
            ?.map((company) => company.name)
            .toList()
            .join(',') ??
        '';
  }

  String getReleaseYear(){
    return releaseDate?.substring(0,4) ?? '';
  }

  String getAverageVoteAsCommaVersion(){
    return voteAverage.toString().replaceAll('.', ',') ;
  }

  String getRunTimeAsFormattedString(){
    if(runtime != null){
      int hour = runtime! ~/ 60  ;
      int min = runtime! % 60;
      return '${hour}h ${min}min';
    }
    return '';
  }

  @override
  String toString() {
    return 'MovieVO(adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homepage: $homepage, imdbId: $imdbId, productionCompanies: $productionCompanies, productionCountries: $productionCountries, revenue: $revenue, runtime: $runtime, spokenLanguage: $spokenLanguage, status: $status, tagLine: $tagLine)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MovieVO &&
      other.adult == adult &&
      other.backdropPath == backdropPath &&
      listEquals(other.genreIds, genreIds) &&
      other.id == id &&
      other.originalLanguage == originalLanguage &&
      other.originalTitle == originalTitle &&
      other.overview == overview &&
      other.popularity == popularity &&
      other.posterPath == posterPath &&
      other.releaseDate == releaseDate &&
      other.title == title &&
      other.video == video &&
      other.voteAverage == voteAverage &&
      other.voteCount == voteCount &&
      other.belongsToCollection == belongsToCollection &&
      other.budget == budget &&
      listEquals(other.genres, genres) &&
      other.homepage == homepage &&
      other.imdbId == imdbId &&
      listEquals(other.productionCompanies, productionCompanies) &&
      listEquals(other.productionCountries, productionCountries) &&
      other.revenue == revenue &&
      other.runtime == runtime &&
      listEquals(other.spokenLanguage, spokenLanguage) &&
      other.status == status &&
      other.tagLine == tagLine &&
      other.isNowPlaying == isNowPlaying &&
      other.isUpcoming == isUpcoming;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
      backdropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode ^
      belongsToCollection.hashCode ^
      budget.hashCode ^
      genres.hashCode ^
      homepage.hashCode ^
      imdbId.hashCode ^
      productionCompanies.hashCode ^
      productionCountries.hashCode ^
      revenue.hashCode ^
      runtime.hashCode ^
      spokenLanguage.hashCode ^
      status.hashCode ^
      tagLine.hashCode ^
      isNowPlaying.hashCode ^
      isUpcoming.hashCode;
  }
}
