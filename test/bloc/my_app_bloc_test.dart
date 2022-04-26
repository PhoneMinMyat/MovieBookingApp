import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/my_app_bloc.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  MyAppBloc myAppBloc = MyAppBloc(TmbaModelImplMock());

  test('Profile Test', (){
    expect(myAppBloc.userProfile, getMockProfile());
  });

  
}