import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/seat_bloc.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  SeatBloc seatBloc = SeatBloc('125', '22-08-2022', TmbaModelImplMock());

  test('Fetch Seat List', () {
    expect(seatBloc.seatingList, getMockMovieSeatList()?.first);
  });

  test('Select And Unselect Seat', () {
    seatBloc.selectSeat(getMockMovieSeatList()?.first.first ?? MovieSeatVO());
    expect(seatBloc.seatingList?.first.isSelected, true);
    expect(seatBloc.selectedSeat, [seatBloc.seatingList?.first.seatName]);
    expect(seatBloc.getSelectedRowAsFormattedString(), seatBloc.seatingList?.first.symbol);
    expect(seatBloc.price, 6);

    seatBloc.selectSeat(getMockMovieSeatList()?.first.last ?? MovieSeatVO());
    seatBloc.selectSeat(getMockMovieSeatList()?.first.first ?? MovieSeatVO());
    expect(seatBloc.seatingList?.first.isSelected, false);
    expect(seatBloc.selectedSeat, [seatBloc.seatingList?.last.seatName]);
    expect(seatBloc.getSelectedRowAsFormattedString(), seatBloc.seatingList?.last.symbol);
    expect(seatBloc.price, 6);
  });
}
