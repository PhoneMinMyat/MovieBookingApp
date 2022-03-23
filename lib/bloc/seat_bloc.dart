import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';

class SeatBloc extends ChangeNotifier {
  //Models
  final TmbaModel _mTmbaModel = TmbaModelImpl();

//STATE VARIABLES
  List<MovieSeatVO>? seatingList;

  List<String>? selectedSeat;
  double price = 0;
  Set<String>? selectedRow;

  SeatBloc(String timeslotId, String date) {
    selectedSeat = [];
    price = 0;
    selectedRow = {};
    //Seating List
    _mTmbaModel.getCinemaSeatingPlan(timeslotId, date).then((seatList) {
      seatingList = seatList;
      notifyListeners();
    }).catchError((error) => print(error));
  }

  void selectSeat(MovieSeatVO seat) {
    MovieSeatVO tempSelectedSeat =
        seatingList?.firstWhere((seatFromList) => seatFromList == seat) ??
            MovieSeatVO();

    print(tempSelectedSeat.seatName);
    List<MovieSeatVO> tempSeatingList =
        seatingList?.map((seat) => seat).toList() ?? [];
    List<String> tempSelectedSeatList =
        selectedSeat?.map((seatName) => seatName).toList() ?? [];
    Set<String> tempSelectedRow = selectedRow?.map((row) => row).toSet() ?? {};
    if (tempSelectedSeat.isSelected == true) {
      tempSeatingList
          .firstWhere((seatFromList) => seatFromList == tempSelectedSeat)
          .isSelected = false;
      tempSelectedSeatList.remove(seat.seatName);
      tempSelectedRow.remove(seat.symbol);

      seatingList = tempSeatingList;
      selectedSeat = tempSelectedSeatList;
      selectedRow = tempSelectedRow;

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
        selectedRow = tempSelectedRow;

        price += seat.price ?? 0;
      }
    }
    notifyListeners();
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
    return selectedRow?.toList().join(',') ?? '';
  }

  String getSelectedSeatAsFormattedString() {
    return selectedSeat?.toList().join(',') ?? '';
  }
}
