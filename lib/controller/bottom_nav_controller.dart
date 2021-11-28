import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomNavController extends ChangeNotifier {
  bool isConnected = false;

  void checkForInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isConnected = true;
        Fluttertoast.showToast(
          msg: 'Connected',
          gravity: ToastGravity.TOP,
        );
      } else {
        isConnected = false;
        Fluttertoast.showToast(
          msg: 'No Internet Connection',
          gravity: ToastGravity.TOP,
        );
      }
      notifyListeners();
    });
  }
}
