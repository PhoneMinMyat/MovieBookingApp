import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class HorizontalMovieListItem extends StatelessWidget {
  final MovieVO? movie;
  final Function(int) onTapMovie;

  const HorizontalMovieListItem({
    required this.movie,
    required this.onTapMovie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HORIZONTAL_MOVIE_LIST_ITEM_WIDTH,
      child: GestureDetector(
        onTap: (){
          onTapMovie(movie?.id ?? 0);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
              child: Image.network(
                '$IMAGE_BASE_URL${movie?.posterPath ?? ""}',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_2x,
            ),
            Text(
              movie?.title ?? '',
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
