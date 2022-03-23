import 'package:barcode_widgets/barcode_flutter.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/bloc/ticket_bloc.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widgets/header_text.dart';
import 'package:provider/provider.dart';

class TicketPage extends StatelessWidget {
  final CheckoutVO checkout;
  const TicketPage({required this.checkout, Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketBloc(checkout.movieId ?? 0),
      child: Selector<TicketBloc, MovieVO?>(
        selector: (context, bloc)=> bloc.movie,
        builder: (context, movie, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const SimpleAppBarView(
            isCrossIcon: true,
            isTicketPage: true,
          ),
          body:(movie == null)? const CircularProgressIndicator() :SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const TitleSectionView(),
                const SizedBox(height: MARGIN_MEDIUM_2x),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                  child: TicketSectionView(
                    movieTitle: movie.title ?? '',
                    movieLength: '${movie.runtime}m',
                    movieImageUrl: movie.backdropPath ?? '',
                    checkout: checkout,
                  ),
                ),
                const SizedBox(height: MARGIN_XXLARGE),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketSectionView extends StatelessWidget {
  final String movieTitle;
  final String movieLength;
  final String movieImageUrl;
  final CheckoutVO checkout;
  const TicketSectionView({
    required this.movieTitle,
    required this.movieLength,
    required this.movieImageUrl,
    required this.checkout,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketMovieImageAndTitleSectionView(
          movieTitle: movieTitle,
          movieLength: movieLength,
          movieUrl: movieImageUrl,
        ),
        const TicketSeparator(),
        ShowTimeDetailsInfoSectionView(
          checkout: checkout,
        ),
        const TicketSeparator(),
        const BarCodeSectionView()
      ],
    );
  }
}

class BarCodeSectionView extends StatelessWidget {
  const BarCodeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          bottom: MARGIN_MEDIUM_3x,
          left: MARGIN_XXLARGE,
          right: MARGIN_XXLARGE),
      decoration: const BoxDecoration(
        color: TICKET_COLOR,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(BUTTON_BORDER_RADIUS),
          bottomRight: Radius.circular(BUTTON_BORDER_RADIUS),
        ),
      ),
      child: FittedBox(
        child: BarCodeImage(
          params: Code128BarCodeParams(
            "GC1547219308",
          ),
        ),
      ),
    );
  }
}

class ShowTimeDetailsInfoSectionView extends StatelessWidget {
  final CheckoutVO checkout;
  const ShowTimeDetailsInfoSectionView({
    required this.checkout,
    Key? key,
  }) : super(key: key);

  String getShowTimeAndDate() {
    String time = checkout.timeslot?.startTime ?? '';
    DateTime tempDate =
        DateFormat("yyyy-MM-dd").parse(checkout.bookingDate ?? '');
    String date = DateFormat("d MMM").format(tempDate);
    String showTimeAndDate = '$time - $date';
    return showTimeAndDate;
  }

  String getCinema() {
    String ticketNo = checkout.bookingNo ?? '';
    String cinema = ticketNo.substring(0, ticketNo.indexOf('-'));

    return cinema;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TICKET_COLOR,
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_3x, vertical: MARGIN_MEDIUM),
      child: Column(
        children: [
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_BOOKING_NO,
            infoText: checkout.bookingNo ?? '',
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_SHOW_TIME,
            infoText: getShowTimeAndDate(),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_THEATER,
            infoText: getCinema(),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_SCREEN,
            infoText: checkout.cinemaId.toString(),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_ROW,
            infoText: checkout.row ?? '',
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_SEATS,
            infoText: checkout.seat ?? '',
          ),
          const SizedBox(height: MARGIN_MEDIUM_2x),
          ShowTimeDetailItem(
            titleText: TICKET_PAGE_PRICE,
            infoText: checkout.total ?? '',
          ),
        ],
      ),
    );
  }
}

class ShowTimeDetailItem extends StatelessWidget {
  final String titleText;
  final String infoText;
  const ShowTimeDetailItem({
    required this.titleText,
    required this.infoText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          titleText,
          style: const TextStyle(color: SECONDARY_TEXT_COLOR),
        ),
        const Spacer(),
        Text(infoText),
      ],
    );
  }
}

class TicketMovieImageAndTitleSectionView extends StatelessWidget {
  final String movieTitle;
  final String movieLength;
  final String movieUrl;
  const TicketMovieImageAndTitleSectionView({
    required this.movieTitle,
    required this.movieLength,
    required this.movieUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TICKET_COLOR,
      //height: TICKET_PAGE_MOVIE_IMAGE_AND_INFO_HEIGHT,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: TicketMovieImageView(
              imageUrl: movieUrl,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2x,
            ),
            child: TicketMovieTitleAndLengthSectionView(
              movieTitle: movieTitle,
              movieLength: movieLength,
            ),
          )
        ],
      ),
    );
  }
}

class TicketMovieTitleAndLengthSectionView extends StatelessWidget {
  final String movieTitle;
  final String movieLength;
  const TicketMovieTitleAndLengthSectionView({
    required this.movieTitle,
    required this.movieLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            movieTitle,
            style: const TextStyle(fontSize: TEXT_REGULAR_3x),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          movieLength,
          style: const TextStyle(
              fontSize: TEXT_REGULAR_2x, color: SECONDARY_TEXT_COLOR),
        )
      ],
    );
  }
}

class TicketMovieImageView extends StatelessWidget {
  final String imageUrl;
  const TicketMovieImageView({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(BUTTON_BORDER_RADIUS),
        topRight: Radius.circular(BUTTON_BORDER_RADIUS),
      ),
      child: Image.network(
        '$IMAGE_BASE_URL$imageUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}

class TitleSectionView extends StatelessWidget {
  const TitleSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        HeaderText(TICKET_PAGE_TITLE),
        Text(
          TICKET_PAGE_SUB_TITLE,
          style:
              TextStyle(color: SECONDARY_TEXT_COLOR, fontSize: TEXT_REGULAR_3x),
        )
      ],
    );
  }
}

class TicketSeparator extends StatelessWidget {
  const TicketSeparator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TICKET_SEPARATOR_HEIGHT,
      color: TICKET_COLOR,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: DottedLine(
                dashColor: SECONDARY_TEXT_COLOR,
                dashLength: 10,
                dashGapLength: 7,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: TICKET_SEPARATOR_HEIGHT / 2,
              height: TICKET_SEPARATOR_HEIGHT,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(TICKET_SEPARATOR_HEIGHT),
                  bottomRight: Radius.circular(TICKET_SEPARATOR_HEIGHT),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: TICKET_SEPARATOR_HEIGHT / 2,
              height: TICKET_SEPARATOR_HEIGHT,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(TICKET_SEPARATOR_HEIGHT),
                  bottomLeft: Radius.circular(TICKET_SEPARATOR_HEIGHT),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
