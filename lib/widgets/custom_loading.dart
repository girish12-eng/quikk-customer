import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quikk_customer/helper/constants.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(Constant.KPrimaryColor),
      child: Center(
        child: Lottie.asset(
          Constant.KLottieAsset + 'loading.json',
          height: 128,
          width: 128
        ),
      ),
    );
  }
}
