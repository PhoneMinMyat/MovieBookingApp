import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/dummy_data.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/pages/snack_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/normal_text.dart';
import 'package:movie_booking_app/widgets/title_text.dart';

class SeatPage extends StatefulWidget {
  final TimeslotsVO time;
  final String date;
  final String movieName;
  final String cinema;
  final int movieId;
  final int cinemaId;

  const SeatPage({
    Key? key,
    required this.time,
    required this.date,
    required this.movieName,
    required this.cinema,
    required this.movieId,
    required this.cinemaId,
  }) : super(key: key);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  //Models
  final TmbaModel _mTmbaModel = TmbaModelImpl();

//STATE VARIABLES
  List<MovieSeatVO>? seatingList;

  //Variables
  List<String> selectedSeat = [];
  double price = 0;
  Set<String> selectedRow = {};

  int getSeatColumnCount() {
    String tempSymbol = seatingList?[0].symbol ?? 'A';
    int numberOfColumn = seatingList
            ?.where((seat) => seat.symbol == tempSymbol)
            .toList()
            .length ??
        1;
    return numberOfColumn;
  }

  void selectSeat(MovieSeatVO seat) {
    setState(() {
      if (seatingList
              ?.firstWhere((seatFromList) => seatFromList == seat)
              .isSelected ==
          true) {
        seatingList
            ?.firstWhere((seatFromList) => seatFromList == seat)
            .isSelected = false;
        selectedSeat.remove(seat.seatName);
        price -= seat.price ?? 0;
        selectedRow.remove(seat.symbol);
      } else {
        if (seatingList
                ?.firstWhere((seatFromList) => seatFromList == seat)
                .isMovieSeatAvailable() ??
            false) {
          seatingList
              ?.firstWhere((seatFromList) => seatFromList == seat)
              .isSelected = true;
          selectedSeat.add(seat.seatName ?? '');
          price += seat.price ?? 0;
          selectedRow.add(seat.symbol ?? '');
        }
      }
    });
  }

  @override
  void initState() {
    // SeatingPlan
    // Network
    _mTmbaModel
        .getCinemaSeatingPlan(
            widget.time.cinemaDayTimeSlotId.toString(), widget.date)
        .then((seatList) {
      setState(() {
        seatingList = seatList;
      });
    }).catchError((error) => handleError(context, error));
    super.initState();
  }

  void handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
      try {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(error.response?.data);
        showErrorAlert(context, errorResponse.message ?? '');
      } on Error catch (_) {
        showErrorAlert(context, error.toString());
      }
    } else {
      showErrorAlert(context, error.toString());
    }
  }

  void showErrorAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error!!!'),
        content: SingleChildScrollView(child: Text(message)),
      ),
    );
  }

  void navigateToSubPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SnackPage(
          bookingDate: widget.date,
          cinemaId: widget.cinemaId,
          selectdSeatName: selectedSeat.join(','),
          cinemaDayTimeslotId: widget.time.cinemaDayTimeSlotId ?? 0,
          movieId: widget.movieId,
          seatPrice: price,
          row: selectedRow.toList().join(','),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBarView(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MovieNameCinemaAndTimeSectionView(
              movieName: widget.movieName,
              cinema: widget.cinema,
              showdate: widget.date,
              time: widget.time.startTime ?? '',
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            (seatingList == null)
                ? const SizedBox(
                    width: 100, height: 100, child: CircularProgressIndicator())
                : SeatSectionView(
                    (seat) => selectSeat(seat),
                    seatList: seatingList ?? [MovieSeatVO()],
                    seatColumnCount: getSeatColumnCount(),
                  ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            const SeatStatusColorSectionView(),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            const DottedLineSectionView(),
            const SizedBox(
              height: MARGIN_MEDIUM_3x,
            ),
            TicketsAndSeatsSectionView(
              selectedNumberOfTicket: selectedSeat.length,
              selectedSeatName: selectedSeat.join(','),
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
              child: FloatingLongButton(
                () {
                  navigateToSubPage(context);
                },
                buttonText: 'Buy Tickets for \$$price',
                isNeedTransparentSpace: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketsAndSeatsSectionView extends StatelessWidget {
  final int selectedNumberOfTicket;
  final String selectedSeatName;
  const TicketsAndSeatsSectionView({
    Key? key,
    required this.selectedNumberOfTicket,
    required this.selectedSeatName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3x),
      child: Column(
        children: [
          Row(
            children: [
              const NormalText('Tickets'),
              const Spacer(),
              Text(selectedNumberOfTicket.toString()),
            ],
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_2x,
          ),
          Row(
            children: [
              const NormalText('Seats'),
              const Spacer(),
              Text(selectedSeatName),
            ],
          )
        ],
      ),
    );
  }
}

class DottedLineSectionView extends StatelessWidget {
  const DottedLineSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: DottedLine(
        dashLength: MARGIN_MEDIUM,
        dashColor: MOVIE_SEAT_AVAILABLE_COLOR,
        dashGapLength: MARGIN_MEDIUM,
      ),
    );
  }
}

class SeatStatusColorSectionView extends StatelessWidget {
  const SeatStatusColorSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: SeatStatusColorCircleAndInfoView(
              seatColor: MOVIE_SEAT_AVAILABLE_COLOR,
              infoTitle: 'Available',
            ),
          ),
          Expanded(
            flex: 1,
            child: SeatStatusColorCircleAndInfoView(
              seatColor: MOVIE_SEAT_TAKEN_COLOR,
              infoTitle: 'Reserved',
            ),
          ),
          Expanded(
            flex: 1,
            child: SeatStatusColorCircleAndInfoView(
              seatColor: MOVIE_SEAT_SELECT_COLOR,
              infoTitle: 'Your selection',
            ),
          ),
        ],
      ),
    );
  }
}

class SeatStatusColorCircleAndInfoView extends StatelessWidget {
  final Color seatColor;
  final String infoTitle;
  const SeatStatusColorCircleAndInfoView({
    required this.seatColor,
    required this.infoTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MARGIN_MEDIUM_3x,
          width: MARGIN_MEDIUM_3x,
          decoration: BoxDecoration(color: seatColor, shape: BoxShape.circle),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Flexible(child: Text(infoTitle)),
      ],
    );
  }
}

class SeatSectionView extends StatelessWidget {
  final List<MovieSeatVO> seatList;
  final Function(MovieSeatVO) selectSeat;
  final int seatColumnCount;
  const SeatSectionView(
    this.selectSeat, {
    required this.seatList,
    required this.seatColumnCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (seatList.length != 0) ? seatList.length : 1,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: (seatColumnCount == 0) ? 1 : seatColumnCount,
              childAspectRatio: 1),
          itemBuilder: (context, index) {
            return SeatView(
              (seat) => selectSeat(seat),
              seatInfo: seatList[index],
            );
          }),
    );
  }
}

class SeatView extends StatelessWidget {
  final Function(MovieSeatVO) selectSeat;
  final MovieSeatVO seatInfo;
  const SeatView(
    this.selectSeat, {
    required this.seatInfo,
    Key? key,
  }) : super(key: key);
  Color getColor() {
    if (seatInfo.isSelected == false) {
      if (seatInfo.isMovieSeatAvailable()) {
        return MOVIE_SEAT_AVAILABLE_COLOR;
      } else if (seatInfo.isMovieSeatEmpty()) {
        return Colors.white;
      } else if (seatInfo.isMovieSeatRowTitle()) {
        return Colors.white;
      } else if (seatInfo.isMovieSeatTaken()) {
        return MOVIE_SEAT_TAKEN_COLOR;
      } else {
        return Colors.white;
      }
    } else {
      return MOVIE_SEAT_SELECT_COLOR;
    }
  }

  String getText() {
    if (seatInfo.isMovieSeatRowTitle()) {
      return seatInfo.symbol ?? '';
    } else {
      if (seatInfo.isSelected == true) {
        return seatInfo.seatName ?? '';
      } else {
        return '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectSeat(seatInfo),
      child: Container(
        decoration: BoxDecoration(
            color: getColor(),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MARGIN_MEDIUM),
                topRight: Radius.circular(MARGIN_MEDIUM))),
        child: Center(
          child: (seatInfo.isSelected == true)
              ? Text(
                  getText(),
                  style: const TextStyle(
                      fontSize: SEAT_TEXT_SIZE, color: Colors.white),
                )
              : Text(getText()),
        ),
      ),
    );
  }
}

class MovieNameCinemaAndTimeSectionView extends StatelessWidget {
  final String movieName;
  final String cinema;
  final String showdate;
  final String time;
  const MovieNameCinemaAndTimeSectionView({
    Key? key,
    required this.movieName,
    required this.cinema,
    required this.showdate,
    required this.time,
  }) : super(key: key);

  String getMovieDateAndTimeAsFormattedString() {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(showdate);
    String day = DateFormat("EEEE, d MMMM").format(tempDate);

    return '$day , $time';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleText(movieName),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        NormalText(cinema),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(getMovieDateAndTimeAsFormattedString())
      ],
    );
  }
}
