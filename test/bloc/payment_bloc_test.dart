import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/payment_bloc.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  PaymentBloc? paymentBloc;

  group('Payment Bloc Test', (){
    setUp((){
      paymentBloc = PaymentBloc(CheckOutRequest(), TmbaModelImplMock());
    });

    test('Check Profile', (){
      expect(paymentBloc?.profile, getMockProfile());
    });

    test('Test Post Checkout', (){
      expect(paymentBloc?.checkout(), completion(equals(getMockCheckOut())));
    });

    test('Change Card Index', (){
      paymentBloc?.changeCard(2);
      expect(paymentBloc?.checkOutRequest.cardId, getMockProfile()?.cards?[2].id);
    });

    //
  });
}