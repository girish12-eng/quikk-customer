import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/screens/my_account/order/order_history_screen.dart';
import 'package:quikk_customer/widgets/order_placed_success_dialog.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushNewScreen(
          context,
          screen: OrderHistoryScreen(),
          withNavBar: false,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation:
          PageTransitionAnimation.cupertino,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OrderSuccessDialog(),
      ),
    );
  }
}
