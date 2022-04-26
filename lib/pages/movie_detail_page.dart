import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_booking_app/bloc/details_bloc.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/pages/pick_time_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/back_button.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/header_text.dart';
import 'package:movie_booking_app/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({required this.movieId, Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  DetailsBloc? detailsBloc;

  @override
  void initState() {
    detailsBloc = DetailsBloc(widget.movieId);
    super.initState();
  }

  @override
  void dispose() {
    detailsBloc?.makeDispose();
    super.dispose();
  }

  void popMovieDetailScreen(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToPickTimePage(
      BuildContext context, int movieId, String movieTitle) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PickTimePage(
              movieId: movieId,
              moiveName: movieTitle,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => detailsBloc,
      child: Selector<DetailsBloc, MovieVO?>(
        selector: (context, bloc) => bloc.movie,
        builder: (context, movie, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  CustomAppBarSectionView(
                    () {
                      popMovieDetailScreen(context);
                    },
                    imageUrl: movie?.backdropPath ?? '',
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_MEDIUM_2x),
                          width: double.infinity,
                          child: TrailerSection(
                            movie: movie ?? MovieVO(),
                          ),
                        ),
                        const SizedBox(
                          height: MARGIN_MEDIUM_2x,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_MEDIUM_2x),
                          child: PlotSummarySectionView(
                            plotText: movie?.overview ?? '',
                          ),
                        ),
                        const SizedBox(
                          height: MARGIN_MEDIUM_2x,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_MEDIUM_2x),
                          child: Selector<DetailsBloc, List<ActorVO>?>(
                            selector: (context, bloc) => bloc.actorList,
                            builder: (context, actorList, child) =>
                                CastSectionView(
                              actorList: actorList ?? [],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: SPACE_FOR_FLOATING_LONG_BUTTON,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
                  child: FloatingLongButton(
                    () {
                      navigateToPickTimePage(
                          context, movie?.id ?? 0, movie?.title ?? '');
                    },
                    buttonText: DETAILS_PAGE_GET_YOUR_TICKET_BUTTON,
                    key: const Key(KEY_DETAILS_CONFIRM),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CastSectionView extends StatelessWidget {
  final List<ActorVO> actorList;
  const CastSectionView({
    required this.actorList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText(
          DETAILS_PAGE_CAST,
          isBold: true,
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        SizedBox(
          height: DETAILS_CAST_HEIGHT,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actorList.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        '$IMAGE_BASE_URL${actorList[index].profilePath}'),
                    fit: BoxFit.cover),
              ),
              width: 75,
              margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2x),
            ),
          ),
        ),
      ],
    );
  }
}

class PlotSummarySectionView extends StatelessWidget {
  final String plotText;
  const PlotSummarySectionView({
    required this.plotText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText(
          DETAILS_PAGE_PLOT_SUMMARY,
          isBold: true,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          plotText,
          textAlign: TextAlign.justify,
          style: const TextStyle(color: SECONDARY_TEXT_COLOR, height: 1.5),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final MovieVO movie;
  const TrailerSection({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(movie.title ?? ''),
        const SizedBox(
          height: MARGIN_MEDIUM_2x,
        ),
        MovieLengthAndRatingSectionView(
          playTime: movie.getRunTimeAsFormattedString(),
          rating: movie.voteAverage ?? 0,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        MovieGenreChipSectionView(
          genreList: movie.getGenreListAsStringList(),
        ),
      ],
    );
  }
}

class MovieGenreChipSectionView extends StatelessWidget {
  final List<String> genreList;
  const MovieGenreChipSectionView({
    required this.genreList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MARGIN_MEDIUM_2x,
      children: [
        ...genreList.map((label) => MovieChip(text: label)),
      ],
    );
  }
}

class MovieChip extends StatelessWidget {
  final String text;
  const MovieChip({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: SECONDARY_TEXT_COLOR, width: 0.1),
      label: Text(
        text,
        style: const TextStyle(color: SECONDARY_TEXT_COLOR),
      ),
    );
  }
}

class MovieLengthAndRatingSectionView extends StatelessWidget {
  final String playTime;
  final double rating;
  const MovieLengthAndRatingSectionView({
    required this.playTime,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SubTitleText(playTime),
        const SizedBox(
          width: MARGIN_MEDIUM_2x,
        ),
        RatingBarIndicator(
          itemCount: 5,
          rating: rating / 2,
          itemSize: RATINGBAR_ITEM_SIZE,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2x,
        ),
        SubTitleText('IMDb $rating')
      ],
    );
  }
}

class CustomAppBarSectionView extends StatelessWidget {
  final Function onTapBackButton;
  final String imageUrl;
  const CustomAppBarSectionView(
    this.onTapBackButton, {
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: SLIVER_APP_BAR_HEIGHT,
      backgroundColor: Colors.white,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: AppBarImageView(imageUrl: imageUrl),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM, vertical: MARGIN_LARGE),
                    child: BackButtonView(
                      () {
                        onTapBackButton();
                      },
                      isWhite: true,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: PlayButtonView(),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: RoundedCornerContainerSection(),
          ),
        ],
      ),
    );
  }
}

class RoundedCornerContainerSection extends StatelessWidget {
  const RoundedCornerContainerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
    );
  }
}

class AppBarImageView extends StatelessWidget {
  final String imageUrl;
  const AppBarImageView({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl != '')
        ? Image.network(
            '$IMAGE_BASE_URL$imageUrl',
            fit: BoxFit.cover,
          )
        : const CircularProgressIndicator();
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DETAILS_SCREEN_PLAY_BUTTON_SIZE,
      decoration: BoxDecoration(
        color: Colors.white54,
        shape: BoxShape.circle,
        border: Border.all(width: 5, color: Colors.white),
      ),
      child: const Center(
          child: Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 45,
      )),
    );
  }
}
