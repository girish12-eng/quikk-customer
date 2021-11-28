import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/my_account/order/order_history_screen.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(Constant.KLottieAsset + 'success.json'),
            Text(
              'Order Placed!',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Your order was placed successfully',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black38,
                  ),
            ),
            Text(
              'Click on button below o view your order',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black38,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () =>pushNewScreen(
                context,
                screen: OrderHistoryScreen(),
                withNavBar: false,
                // OPTIONAL VALUE. True by default.
                pageTransitionAnimation:
                PageTransitionAnimation.cupertino,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Text(
                      'view order',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
