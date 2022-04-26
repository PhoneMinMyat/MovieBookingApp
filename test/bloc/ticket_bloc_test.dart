import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/ticket_bloc.dart';

import '../data/models/the_movie_db_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  TicketBloc ticketBloc = TicketBloc(214, TheMovieDbModelImplMock());

  test('fetch Movie Details', (){
    expect(ticketBloc.movie, getMockMovieListForTest()?.first);
  });
}