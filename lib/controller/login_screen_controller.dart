import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/helper.dart';
import 'package:quikk_customer/models/user_model.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends ChangeNotifier {
  late SharedPreferences _preferences;
  TextEditingController _emailTED = TextEditingController();
  TextEditingController _passwordTED = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  GlobalKey<FormState> get getFOrmKey {
    return _key;
  }

  TextEditingController get getEmailTED {
    return _emailTED;
  }

  TextEditingController get getPasswordTED {
    return _passwordTED;
  }

  String? validateFields(String v) {
    if (v.isEmpty) return 'This field is required';
    return null;
  }

  void onSaveEmailTED(String v) {
    _emailTED.text = v;
  }

  void onSavePasswordTED(String v) {
    _passwordTED.text = v;
  }

  void onLoginButtonPressed(BuildContext context) async {
    if (_key.currentState!.validate()) {
      print('vv');
      Helper.showLoadingDialog(context);
      _key.currentState!.save();
      UserModel user = UserModel();
      user.email = _emailTED.text;
      user.password = _passwordTED.text;
      var res = await loginRepo(user);
      if (res != null) {
        _preferences = await SharedPreferences.getInstance();
        _preferences.setString('token', res.token!);
        _preferences.setString('name', res.data!.name!);
        _preferences.setString('email', res.data!.email!);
        _preferences.setString('phone', res.data!.phone!);
        Navigator.pop(context);
        pushNewScreen(
          context,
          screen: BottomNavigationScreen(),
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      } else {
        Navigator.pop(context);
      }
    }
  }
}
