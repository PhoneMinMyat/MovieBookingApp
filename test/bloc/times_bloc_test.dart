import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/times_bloc.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  TimeBloc timeBloc = TimeBloc(123, TmbaModelImplMock());
  test('Fetch Cinema List', (){
    expect(timeBloc.cinemaList, getMockCinemaVOList());
  });
}