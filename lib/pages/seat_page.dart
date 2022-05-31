import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/bloc/seat_bloc.dart';

import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/pages/snack_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/normal_text.dart';
import 'package:movie_booking_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

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
  SeatBloc? seatBloc;

  @override
  void initState() {
    seatBloc =
        SeatBloc(widget.time.cinemaDayTimeSlotId.toString(), widget.date);
    super.initState();
  }

  @override
  void dispose() {
    seatBloc?.makeDispose();
    super.dispose();
  }

  void navigateToSnackPage(
      {required BuildContext context,
      required String selectedSeat,
      required double price,
      required String selectedRow}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SnackPage(
          bookingDate: widget.date,
          cinemaId: widget.cinemaId,
          selectdSeatName: selectedSeat,
          cinemaDayTimeslotId: widget.time.cinemaDayTimeSlotId ?? 0,
          movieId: widget.movieId,
          seatPrice: price,
          row: selectedRow,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => seatBloc,
      child: Selector<SeatBloc, List<MovieSeatVO>?>(
          selector: (context, bloc) => bloc.seatingList,
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, seatingList, child) {
            SeatBloc bloc = Provider.of<SeatBloc>(context, listen: false);
            return Scaffold(
              appBar: const SimpleAppBarView(),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                key: const Key(KEY_SEAT_PAGE_SCROLLVIEW),
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
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator())
                        : SeatSectionView(
                            (seat) {
                              bloc.selectSeat(seat);
                            },
                            seatList: seatingList,
                            seatColumnCount: bloc.getSeatColumnCount(),
                          ),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    const SeatStatusColorSectionView(
                      key: Key(KEY_SEAT_STATE_COLOR),
                    ),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    const DottedLineSectionView(),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3x,
                    ),
                    Selector<SeatBloc, List<String>?>(
                      selector: (context, bloc) => bloc.selectedSeat,
                      builder: (context, selectedSeat, child) =>
                          TicketsAndSeatsSectionView(
                        selectedNumberOfTicket: selectedSeat?.length ?? 0,
                        selectedSeatName: selectedSeat?.join(',') ?? '',
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2x),
                      child: Selector<SeatBloc, double>(
                        selector: (context, bloc) => bloc.price,
                        builder: (context, price, child) => FloatingLongButton(
                          () {
                            navigateToSnackPage(
                                context: context,
                                price: price,
                                selectedRow:
                                    bloc.getSelectedRowAsFormattedString(),
                                selectedSeat:
                                    bloc.getSelectedSeatAsFormattedString());
                          },
                          buttonText: 'Buy Tickets for \$$price',
                          isNeedTransparentSpace: false,
                          key: const Key(KEY_SEAT_CONFIRM),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
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
        children: [
          const Expanded(
            flex: 1,
            child: SeatStatusColorCircleAndInfoView(
              seatColor: MOVIE_SEAT_AVAILABLE_COLOR,
              infoTitle: 'Available',
            ),
          ),
          const Expanded(
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
          itemCount: (seatList.isNotEmpty) ? seatList.length : 1,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: (seatColumnCount == 0) ? 1 : seatColumnCount,
              childAspectRatio: 1),
          itemBuilder: (context, index) {
            return SeatView(
              (seat) => selectSeat(seat),
              key: Key(KEY_SEAT_ITEM + index.toString()),
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
      onTap: () {
        selectSeat(seatInfo);
      },
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
          child: TitleText(movieName, isSeatPage: true,),
        ),
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
