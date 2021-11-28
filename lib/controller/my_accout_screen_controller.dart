import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/models/account_refer_model.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/screens/splash_screen.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountScreenController extends ChangeNotifier {
  late SharedPreferences _preferences;
  String? _name;
  String? _email;
  String? _phoneNO;
  bool _loading = false;
  AccountReferModel? _referModel;

  void init() {
    getDetails();
    getReferDetails();
  }

  void onReferCodeClick() {
    Share.share(
      'Download Quikk and use referral code ${_referModel!.userRefcode} to get ${_referModel!.referalCoin} Quikk coins.\nhttps://play.google.com/store/apps/details?id=com.graphhene.quikk.customer',
    );
  }

  void getReferDetails() async {
    _loading = true;
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    _referModel = await getReferDetailsRepo(token);
    _loading = false;
    notifyListeners();
  }

  void getDetails() async {
    _preferences = await SharedPreferences.getInstance();
    _name = _preferences.getString('name')!;
    _email = _preferences.getString('email')!;
    _phoneNO = _preferences.getString('phone')!;
    // _loading = false;
    notifyListeners();
  }

  void onLogoutButtonPressed(BuildContext context) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Do you want to logout?'),
        actions: [
          ElevatedButton(
            onPressed: () => print(Navigator.of(context).canPop()),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => onLogOutButtonPressed(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void onLogOutButtonPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text('Do you want to logout?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          OutlinedButton(
            onPressed: () => logout(context),
            child: Text(
              'Logout',
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
    );
  }

  void logout(BuildContext context) async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.remove('token');
    await _preferences.remove('name');
    await _preferences.remove('email');
    await _preferences.remove('phone');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => SplashScreen(),
        ),
        (route) => false);
  }

  String get getName {
    return _name!;
  }

  String get getEmail {
    return _email!;
  }

  String get getPhone {
    return _phoneNO!;
  }

  bool get getLoading {
    return _loading;
  }

  AccountReferModel? get getAccountReferModel {
    return _referModel;
  }
}
