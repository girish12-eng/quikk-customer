import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/my_account/order/order_history_screen.dart';

class PaymentProcessDialog extends StatelessWidget {
  const PaymentProcessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(Constant.KLottieAsset + 'payment_loading.json'),
            Text(
              'Payment Processing!',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'please don\'t press back button or refresh the page!!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black38,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              // backgroundColor: Colors.red,
              color: Color(Constant.KPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
