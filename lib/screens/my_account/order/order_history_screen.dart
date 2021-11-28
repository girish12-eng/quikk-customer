import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quikk_customer/controller/order_history_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';
import 'package:quikk_customer/widgets/custom_order_history_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderHistoryController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<OrderHistoryController>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavigationScreen(),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BottomNavigationScreen(),
                  ),
                  (route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Order History',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: controller.getLoading
            ? CustomLoading()
            : controller.getOrders.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(Constant.KLottieAsset + 'no_order.json'),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'No order to show',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  )
                : SmartRefresher(
                    controller: controller.getRefreshController,
                    onRefresh: () async {
                      // await Future.delayed(Duration(seconds: 4));
                      controller.init().then(
                            (value) => controller.getRefreshController
                                .refreshCompleted(),
                          );
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return CustomOrderHistoryCard(
                          order: controller.getOrders[index],
                        );
                      },
                      itemCount: controller.getOrders.length,
                    ),
                  ),
      ),
    );
  }
}
