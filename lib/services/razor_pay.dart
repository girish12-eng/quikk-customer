import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService extends ChangeNotifier {
  late Razorpay _razorpay;

  void init(handlePaymentSuccess, handlePaymentError, handleExternalWallet) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print('Payment success');
  //   print(response.signature);
  //   print(response.orderId);
  //   print(response.paymentId);
  //   // Do something when payment succeeds
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(msg: 'Payment fails');
  //   print('payment fail');
  //   print('paymasdsafeggl');
  //   print(response.code);
  //   print(response.message);
  //   // Do something when payment fails
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  // }

  void openCheckout(
      int amount, String phoneNo, String email, String orderId) async {
    var options = {
      'key': Constant.KRazorPayKey,
      'amount': amount,
      'name': 'Quikk.',
      'order_id': orderId,
      'description': 'Delivery',
      'prefill': {'contact': '$phoneNo', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
}
