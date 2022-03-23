import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/date_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';

class TimeBloc extends ChangeNotifier {
  //Modal
  final TmbaModel mTmbaModel = TmbaModelImpl();

  int movieId;

  List<DateVO>? movieShowDateList;

  List<CinemaVO>? cinemaList;
  TimeslotsVO selectedTimeslot = TimeslotsVO();
  String selectedCinema = '';
  // String selectedDate;
  int selectedCinemaId = 0;

  TimeBloc(this.movieId) {
    movieShowDateList = List.generate(14, (index) => index).map((numberOfDays) {
      return DateTime.now().add(Duration(days: numberOfDays));
    }).map((dateTime) {
      return DateVO(
        date: DateFormat('yyyy-MM-dd').format(dateTime),
        weekday: dateTime.weekday,
        isSelected: false,
      );
    }).toList();

    movieShowDateList?.first.isSelected = true;

    getCinemaList(movieId);
  }

  String getSelectedDate() {
    String selectedDate = movieShowDateList
            ?.where((date) => date.isSelected == true)
            .toList()
            .first
            .date
            .toString() ??
        '';
    return selectedDate;
  }

  TimeslotsVO getSelectedTimeslot() {
    return selectedTimeslot;
  }

  String getSelectedCinema() {
    return selectedCinema;
  }

  int getSelectedCinemaId() {
    return selectedCinemaId;
  }

  void selectDate(int index) {
    List<DateVO> tempDateList = movieShowDateList?.map((date) {
          DateVO tempDate = date;
          tempDate.isSelected = false;
          return tempDate;
        }).toList() ??
        [];
    tempDateList[index].isSelected = true;

    movieShowDateList = tempDateList;

    getCinemaList(movieId);
    notifyListeners();
  }

  void getCinemaList(int movieId) {
    selectedTimeslot = TimeslotsVO();
    selectedCinema = '';
    selectedCinemaId = 0;

    //Database
    mTmbaModel
        .getCinemaDayTimeslotFromDatabase(getSelectedDate(), movieId.toString())
        .listen((cinemaListFromHive) {
      cinemaList = cinemaListFromHive?.cinemaList;
      notifyListeners();
    }).onError((error) => print(error));
  }

  void selectTimeslot(TimeslotsVO timeslot) {
    selectedTimeslot = timeslot;
    List<CinemaVO> tempCinemaList = cinemaList?.map((cinema) {
          CinemaVO tempCinema = cinema;
          tempCinema.makeAllTimeslotsChangeNotSelected();
          tempCinema.searhAndSelectTimeslot(
              selectedTimeslot.cinemaDayTimeSlotId ?? 0);

          if (tempCinema.checkTimeslotContain(
              selectedTimeslot.cinemaDayTimeSlotId ?? 0)) {
            selectedCinema = tempCinema.cinema ?? '';
            selectedCinemaId = tempCinema.cinemaId ?? 0;
          }

          return tempCinema;
        }).toList() ??
        [];

    cinemaList = tempCinemaList;
    print('change');

    notifyListeners();
  }
}
