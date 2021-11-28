import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/splash_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SplashScreenController>(context, listen: false).init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Constant.KAsset + 'logo.png'),
              Text(
                'Adding speed to your deliveries',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
