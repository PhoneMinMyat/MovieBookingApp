import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';

class SeatBloc extends ChangeNotifier {
  //Variables
  bool isDispose = false;

  //Models
  TmbaModel _mTmbaModel = TmbaModelImpl();

//STATE VARIABLES
  List<MovieSeatVO>? seatingList;

  List<String>? selectedSeat;
  double price = 0;
  Set<String>? selectedRow;

  List<String>? tempSelectedRowAsList;

  SeatBloc(String timeslotId, String date, [TmbaModel? tmbaModel]) {
    if (tmbaModel != null) {
      _mTmbaModel = tmbaModel;
    }
    selectedSeat = [];
    price = 0;
    selectedRow = {};
    //Seating List
    _mTmbaModel.getCinemaSeatingPlan(timeslotId, date).then((seatList) {
      seatingList = seatList;
      seatingList?.forEach((seat) => print(seat.id));
      safeNotifyListeners();
    }).catchError((error) => print(error));
  }

  void selectSeat(MovieSeatVO seat) {
    print(seat.id);
    print(seat.seatName);
    MovieSeatVO tempSelectedSeat =
        seatingList?.firstWhere((seatFromList) => seatFromList.id == seat.id && seatFromList.seatName == seat.seatName) ??
            MovieSeatVO();

    List<MovieSeatVO> tempSeatingList =
        seatingList?.map((seat) => seat).toList() ?? [];
    List<String> tempSelectedSeatList =
        selectedSeat?.map((seatName) => seatName).toList() ?? [];
    List<String> tempSelectedRow = tempSelectedRowAsList ?? [];

    if (tempSelectedSeat.isSelected == true) {
      tempSeatingList
          .firstWhere((seatFromList) => seatFromList == tempSelectedSeat)
          .isSelected = false;
      tempSelectedSeatList.remove(seat.seatName);
      tempSelectedRow.remove(seat.symbol);

      seatingList = tempSeatingList;
      selectedSeat = tempSelectedSeatList;
      tempSelectedRowAsList = tempSelectedRow;

      price -= seat.price ?? 0;
    } else {
      if (tempSelectedSeat.isMovieSeatAvailable()) {
        tempSeatingList
            .firstWhere((seatFromList) => seatFromList == tempSelectedSeat)
            .isSelected = true;

        tempSelectedSeatList.add(seat.seatName ?? '');
        tempSelectedRow.add(seat.symbol ?? '');

        seatingList = tempSeatingList;
        selectedSeat = tempSelectedSeatList;
        tempSelectedRowAsList = tempSelectedRow;

        price += seat.price ?? 0;
      }
    }
    safeNotifyListeners();
  }

  int getSeatColumnCount() {
    String tempSymbol = seatingList?[0].symbol ?? 'A';
    int numberOfColumn = seatingList
            ?.where((seat) => seat.symbol == tempSymbol)
            .toList()
            .length ??
        1;
    return numberOfColumn;
  }

  String getSelectedRowAsFormattedString() {
    selectedRow = tempSelectedRowAsList?.toSet();
    return selectedRow?.toList().join(',') ?? '';
  }

  String getSelectedSeatAsFormattedString() {
    return selectedSeat?.toList().join(',') ?? '';
  }

  void safeNotifyListeners() {
    if (isDispose == false) {
      notifyListeners();
    }
  }

  void makeDispose() {
    if (isDispose == false) {
      isDispose = true;
    }
  }
}
