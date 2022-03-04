import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/models/the_move_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class HorizontalMovieListItem extends StatefulWidget {
  final MovieVO? movie;

  const HorizontalMovieListItem({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  State<HorizontalMovieListItem> createState() =>
      _HorizontalMovieListItemState();
}

class _HorizontalMovieListItemState extends State<HorizontalMovieListItem> {
  final TheMovieDbModel mMovieModel = TheMovieDbModelImpl();
  String? movieGenres;
  @override
  void initState() {
    mMovieModel
        .getGenresById(widget.movie?.genreIds ?? [])
        .then((genresAsString) => movieGenres = genresAsString);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2x),
      width: HORIZONTAL_MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
            child: Image.network(
              '$IMAGE_BASE_URL${widget.movie?.posterPath ?? ""}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_2x,
          ),
          Text(
            widget.movie?.title ?? '',
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            // '${widget.movie?.getGenreAsSlashSeparatedString()} . ${widget.movie?.getRunTimeAsFormattedString()}',
            movieGenres ?? '',
            
            style: const TextStyle(
              color: SECONDARY_TEXT_COLOR,
              fontSize: HORIZONTAL_MOVIE_GENRE_TEXT_SIZE,
            ),
          ),
        ],
      ),
    );
  }
}
