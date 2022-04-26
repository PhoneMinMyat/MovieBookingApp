import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/persistence/daos/payment_method_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentMethodDaoImplMock extends PaymentMethodDao{
  Map<int, PaymentMethodVO> paymentMethodFromDatabaseMock = {};
  @override
  List<PaymentMethodVO> getAllPaymentMethods() {
   return getMockPaymentMethodList();
  }

  @override
  Stream<void> getPaymentMethodEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<List<PaymentMethodVO>> getPaymentMethodStream() {
   return Stream.value(getMockPaymentMethodList());
  }

  @override
  void savePaymentList(List<PaymentMethodVO> paymentList) {
    paymentList.forEach((payment) { 
      paymentMethodFromDatabaseMock[payment.id ?? 0] = payment;
    });
  }

}