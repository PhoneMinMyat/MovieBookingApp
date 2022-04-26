import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';

abstract class PaymentMethodDao {
  

  void savePaymentList(List<PaymentMethodVO> paymentList);

  List<PaymentMethodVO> getAllPaymentMethods();

  //Reactive
  Stream<void> getPaymentMethodEventStream();

  Stream<List<PaymentMethodVO>> getPaymentMethodStream();

 
}
