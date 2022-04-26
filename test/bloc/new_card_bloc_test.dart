import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/new_card_bloc.dart';

import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  NewCardBloc newCardBloc = NewCardBloc(TmbaModelImplMock());

  test('Add New Card Bloc', () {
    expect(
        newCardBloc.createCard(
            cardNumber: '46464644',
            cardHolder: 'John',
            expiration: '02/22',
            cvc: '555'),
        completion(equals(getMockCardList())));
  });
}
