import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/snack_bloc.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  SnackBloc? snackBloc;

  group('Snack Bloc Test', (){
    setUp((){
      snackBloc = SnackBloc(TmbaModelImplMock());
    });

    test('Fetch Snack List', (){
      expect(snackBloc?.snackList, getMockSnackList());
    });

    test('Fetch Payment Methond List', (){
      expect(snackBloc?.paymentMethodList, getMockPaymentMethodList());
    });

    group('Increase And Decrease Snack COunt', (){

      test('Increase Snack Count', (){
        snackBloc?.increaseCounter(1);
        snackBloc?.increaseCounter(2);
        snackBloc?.increaseCounter(3);

        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==1).quantity, 1);
        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==2).quantity, 1);
        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==3).quantity, 1);
        expect(snackBloc?.totalPrice, 9);
      });

       test('Decrease Snack Count', (){
        snackBloc?.decreaseCounter(1);
        snackBloc?.decreaseCounter(2);
        snackBloc?.decreaseCounter(3);

        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==1).quantity, 0);
        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==2).quantity, 0);
        expect(snackBloc?.snackList?.firstWhere((element) => element.id ==3).quantity, 0);
        expect(snackBloc?.totalPrice, 0);
      });
    });
  });
}