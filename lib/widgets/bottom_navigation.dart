import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/bottom_nav_controller.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/res/colors.dart';
import 'package:quikk_customer/screens/my_account/Account_screen.dart';
import 'package:quikk_customer/screens/cart_screen.dart';
import 'package:quikk_customer/screens/home_screen.dart';
import 'package:quikk_customer/screens/my_account/order/order_history_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const id = 'BottomNavigationScreen';

  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Widget> _screens = [
    HomeScreen(),
    // AllCategoryScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    AccountScreen(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BottomNavController>(context, listen: false).checkForInternet();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CartController>(context);
    var bController = Provider.of<BottomNavController>(context);

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text('Do you want to exit?'),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              OutlinedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Exit',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar:
        Container(
          margin: EdgeInsets.only(left: 16, right: 16,bottom: 16),
          decoration: BoxDecoration(
            color: Color(Constant.KSecondaryColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                      ),
                      controller.getCart.length == 0
                          ? SizedBox()
                          : Positioned(
                              right: 0,
                              top: 0,
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.black,
                                child: Center(
                                  child: Text(
                                    controller.getCart.length.toString(),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                  label: 'Cart'),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_mall),
                label: 'Order',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            ],
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.white,
            onTap: (v) {
              setState(() {
                selectedIndex = v;
              });
            },
          ),
        ),
        body: bController.isConnected
            ? _screens[selectedIndex]
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    Constant.KLottieAsset + 'no_internet.json',
                  ),
                  Text(
                    'No internet connection',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
      ),
    );
  }
}
