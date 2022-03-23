import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/bloc/details_bloc.dart';
import 'package:movie_booking_app/bloc/times_bloc.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/date_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/pages/seat_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/widgets/back_button.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class PickTimePage extends StatelessWidget {
  final int movieId;
  final String moiveName;

  const PickTimePage({required this.movieId, required this.moiveName, Key? key})
      : super(key: key);

  void navigatiorToSeatPage(
      {required BuildContext context,
      required TimeslotsVO selectedTimeslot,
      required String date,
      required String selectedCinema,
      required int selectedCinemaId}) {
    if (selectedTimeslot.cinemaDayTimeSlotId != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SeatPage(
            date: date,
            movieName: moiveName,
            time: selectedTimeslot,
            cinema: selectedCinema,
            movieId: movieId,
            cinemaId: selectedCinemaId,
          ),
        ),
      );
      print(selectedCinema);
      print(selectedTimeslot.startTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TimeBloc(movieId),
        child: Selector<TimeBloc, List<DateVO>?>(
          selector: (context, bloc) => bloc.movieShowDateList,
          builder: (context, movieShowDateList, child) =>
              Selector<TimeBloc, List<CinemaVO>?>(
            selector: (context, bloc) => bloc.cinemaList,
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, cinemaList, child) {
              TimeBloc bloc = Provider.of<TimeBloc>(context, listen: false);
              return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      CustomSliverAppBarView(
                        (index) {
                          TimeBloc bloc =
                              Provider.of<TimeBloc>(context, listen: false);
                          bloc.selectDate(index);
                        },
                        movieShowDateList: movieShowDateList ?? [],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ChoseMovieTypeAndTimeSectionView((timeslot) {
                              TimeBloc bloc =
                                  Provider.of<TimeBloc>(context, listen: false);
                              bloc.selectTimeslot(timeslot);
                              print('send trigger');
                            }, movieTimeList: cinemaList ?? []),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2x),
                      child: FloatingLongButton(() {
                        navigatiorToSeatPage(
                            context: context,
                            date: bloc.getSelectedDate(),
                            selectedCinema: bloc.getSelectedCinema(),
                            selectedCinemaId: bloc.getSelectedCinemaId(),
                            selectedTimeslot: bloc.getSelectedTimeslot());
                      }, buttonText: NEXT),
                    ),
                  ),
                ],
              ),
            );
            }
          ),
        ));
  }
}

class ChoseMovieTypeAndTimeSectionView extends StatelessWidget {
  final List<CinemaVO> movieTimeList;
  final Function(TimeslotsVO) timeslotTap;
  const ChoseMovieTypeAndTimeSectionView(
    this.timeslotTap, {
    Key? key,
    required this.movieTimeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: movieTimeList.length,
        itemBuilder: (context, index) {
          return ChoseMovieTypeAndTime((timeslot) => timeslotTap(timeslot),
              timeList: movieTimeList[index].timeslots ?? [],
              titleText: movieTimeList[index].cinema ?? '');
        });
  }
}

class ChoseMovieTypeAndTime extends StatelessWidget {
  final String titleText;
  final List<TimeslotsVO> timeList;
  final Function(TimeslotsVO) timeslotTap;
  const ChoseMovieTypeAndTime(
    this.timeslotTap, {
    required this.timeList,
    required this.titleText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(titleText),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: timeList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: MARGIN_MEDIUM_2x,
                  mainAxisSpacing: MARGIN_CARD_MEDIUM_2,
                  crossAxisCount: 3,
                  childAspectRatio: 2.5),
              itemBuilder: (context, index) {
                TimeslotsVO tempTime = timeList[index];
                return GestureDetector(
                  onTap: () => timeslotTap(tempTime),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: SECONDARY_TEXT_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      color: (tempTime.isSelected ?? false)
                          ? PRIMARY_COLOR
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        tempTime.startTime ?? '',
                        style: TextStyle(
                          color: (tempTime.isSelected ?? false)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: MARGIN_MEDIUM_3x,
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBarView extends StatelessWidget {
  final List<DateVO> movieShowDateList;
  final Function(int) selectDate;
  const CustomSliverAppBarView(
    this.selectDate, {
    required this.movieShowDateList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MediaQuery.of(context).size.height * 0.15,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(children: [
              Positioned.fill(
                child: ChooseDateSectionView(
                  (index) => selectDate(index),
                  movieShowDateList: movieShowDateList,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: MARGIN_MEDIUM, top: MARGIN_XLARGE),
                  child: BackButtonView(
                    () {
                      Navigator.pop(context);
                    },
                    isWhite: true,
                  ),
                ),
              ),
            ]),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: RoundedCornerView(),
          )
        ],
      ),
    );
  }
}

class RoundedCornerView extends StatelessWidget {
  const RoundedCornerView({
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

class ChooseDateSectionView extends StatelessWidget {
  final List<DateVO> movieShowDateList;
  final Function(int) selectDate;
  const ChooseDateSectionView(
    this.selectDate, {
    required this.movieShowDateList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2x,
            right: MARGIN_MEDIUM_2x,
            top: MARGIN_XXLARGE + MARGIN_XLARGE),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          DateVO date = movieShowDateList[index];
          bool isSelected = date.isSelected ?? false;
          return GestureDetector(
            onTap: () => selectDate(index),
            child: Column(
              children: [
                Text(
                  date.getWeekday(),
                  style: TextStyle(
                      color: (isSelected) ? Colors.white : Colors.grey,
                      fontSize: (isSelected) ? TEXT_HEADING : TEXT_REGULAR_3x,
                      fontWeight: (isSelected) ? FontWeight.w700 : null),
                ),
                Text(
                  date.getDay(),
                  style: TextStyle(
                      color: (isSelected) ? Colors.white : Colors.grey,
                      fontSize:
                          (isSelected) ? TEXT_REGULAR_3x : TEXT_REGULAR_2x,
                      fontWeight: (isSelected) ? FontWeight.w700 : null),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: MARGIN_MEDIUM_2x,
          );
        },
        itemCount: movieShowDateList.length);
  }
}
