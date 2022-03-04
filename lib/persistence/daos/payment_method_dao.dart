import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class PaymentMethodDao {
  static final PaymentMethodDao _sigleton = PaymentMethodDao._internal();

  factory PaymentMethodDao() {
    return _sigleton;
  }

  PaymentMethodDao._internal();

  void savePaymentList(List<PaymentMethodVO> paymentList) async {
    Map<int, PaymentMethodVO> paymentMap = Map.fromIterable(paymentList,
        key: (payment) => payment.id, value: (payment) => payment);

    await getPaymentMethodBox().putAll(paymentMap);
  }

  List<PaymentMethodVO> getAllPaymentMethods() {
    List<PaymentMethodVO> paymentMethodList =
        getPaymentMethodBox().values.toList();
    if (paymentMethodList.isNotEmpty) {
      return paymentMethodList;
    } else {
      return [];
    }
  }

  //Reactive
  Stream<void> getPaymentMethodEventStream(){
    return getPaymentMethodBox().watch();
  }

  Stream<List<PaymentMethodVO>> getPaymentMethodStream(){
    return Stream.value(getAllPaymentMethods());
  }

  Box<PaymentMethodVO> getPaymentMethodBox() {
    return Hive.box<PaymentMethodVO>(BOX_NAME_PAYMENT_METHOD_VO);
  }
}
