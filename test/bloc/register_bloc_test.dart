import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/register_bloc.dart';

import '../data/models/tmba_model_impl_mock.dart';

void main() {
  RegisterBloc registerBloc = RegisterBloc(TmbaModelImplMock());

  test('Register User', () {
    expect(
        registerBloc.registerUser(
            'John', 'test123@gmail.com', '+9546464164', '123456'),
        completion(equals(true)));
  });

  test('Log in with Email', () {
    expect(
        registerBloc.loginWithEmail(
            'John', 'test123@gmail.com'),
        completion(equals(true)));
  });

 
}
