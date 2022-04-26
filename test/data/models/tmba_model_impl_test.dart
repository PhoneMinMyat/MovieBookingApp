import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';

import '../../mock_data/mock_data.dart';
import '../../network/tmba_data_agent_impl_mock.dart';
import '../../persistence/cinema_dao_impl_mock.dart';
import '../../persistence/payment_method_dao_impl_mock.dart';
import '../../persistence/profile_dao_impl_mock.dart';
import '../../persistence/snack_dao_impl_mock.dart';

void main() {
  group('Tmba Model Testing', () {
    var tmbaModel = TmbaModelImpl();

    setUp(() {
      tmbaModel.setDaoAndDataAgent(
          ProfileDaoImplMock(),
          CinemaDaoImplMock(),
          SnackDaoImplMock(),
          PaymentMethodDaoImplMock(),
          TmbaDataAgentImplMock());
    });

    test('Post Register', () {
      expect(
        tmbaModel.postRegisterData('john', 'john@gmail.com', '+956464641',
            '123456', 'asd456fs4d64ag4r', 'fb644dsf6a464dfs'),
        completion(
          equals(
            getMockProfile(),
          ),
        ),
      );
    });

    test('Post Login With Gmail', () {
      expect(
        tmbaModel.postLogInWithGmail('email', 'password'),
        completion(
          equals(
            getMockProfile(),
          ),
        ),
      );
    });

    test('Post Login With Google', () {
      expect(
        tmbaModel.postLogInWithGoogle('ass5sd4f64a6ds'),
        completion(
          equals(
            getMockProfile(),
          ),
        ),
      );
    });

    test('Post Login With Facebook', () {
      expect(
        tmbaModel.postLogInWithFacebook('ass5sd4f64a6ds'),
        completion(
          equals(
            getMockProfile(),
          ),
        ),
      );
    });

    test('Log out', () {
      expect(
        tmbaModel.postLogOut(),
        completion(
          equals(getMockGetLogInResponse().code),
        ),
      );
    });

    test('Get Cinema Seating Plan', () {
      expect(
        tmbaModel.getCinemaSeatingPlan('1', '4-8-2022'),
        completion(
          equals(
            getMockMovieSeatList()?.expand((seat) => seat).toList().map((seat) {
              seat.isSelected = false;
              return seat;
            }).toList(),
          ),
        ),
      );
    });

    test('Post Create Card', () {
      expect(
        tmbaModel.postCreateCard('34646464', 'John', '02/22', '555'),
        completion(
          equals(getMockCardList()),
        ),
      );
    });

    test('Post Check Out', () {
      expect(
        tmbaModel.postCheckout(CheckOutRequest()),
        completion(
          equals(getMockCheckOut()),
        ),
      );
    });

    test('Get Profile From Database', () {
      expect(
        tmbaModel.getProfileFromDatabase(),
        emits(
          getMockProfile(),
        ),
      );
    });

    test('Get CinemaDayTime From Database', () {
      expect(
        tmbaModel.getCinemaDayTimeslotFromDatabase('04-08-2022', '6546'),
        emits(
          getMockCinemaListVO(),
        ),
      );
    });

     test('Get SnackList From Database', () {
      expect(
        tmbaModel.getSnackListFromDatabase(),
        emits(
          getMockSnackList(),
        ),
      );
    });

     test('Get PaymentMethod From Database', () {
      expect(
        tmbaModel.getPaymentMethodFromDatabase(),
        emits(
          getMockPaymentMethodList(),
        ),
      );
    });

    //
  });
}
