import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/persistence/daos/payment_method_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class PaymentMethodDaoImpl extends PaymentMethodDao{
  static final PaymentMethodDaoImpl _sigleton = PaymentMethodDaoImpl._internal();

  factory PaymentMethodDaoImpl() {
    return _sigleton;
  }

  PaymentMethodDaoImpl._internal();

  @override
  void savePaymentList(List<PaymentMethodVO> paymentList) async {
    Map<int, PaymentMethodVO> paymentMap = Map.fromIterable(paymentList,
        key: (payment) => payment.id, value: (payment) => payment);

    await getPaymentMethodBox().putAll(paymentMap);
  }

  @override
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
  @override
  Stream<void> getPaymentMethodEventStream(){
    return getPaymentMethodBox().watch();
  }

  @override
  Stream<List<PaymentMethodVO>> getPaymentMethodStream(){
    return Stream.value(getAllPaymentMethods());
  }

  Box<PaymentMethodVO> getPaymentMethodBox() {
    return Hive.box<PaymentMethodVO>(BOX_NAME_PAYMENT_METHOD_VO);
  }
}
