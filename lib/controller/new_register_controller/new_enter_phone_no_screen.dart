import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/screens/new_register_flow/new_enter_otp_screen.dart';

class NewEnterPhoneNoScreenController {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _phoneNoTED = TextEditingController();

  String? validatePhone(String v) {
    if (v.isEmpty) return 'This field is required';
    if (v.length != 10) return 'Please enter valid phone number';
    return null;
  }

  void onSavePhoneNo(String v) {
    _phoneNoTED.text = v;
  }

  void onSendCodeButtonPressed(BuildContext context) {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      pushNewScreen(
        context,
        screen: NewEnterOtpScreen(phoneNO: _phoneNoTED.text),
      );
    }
  }

  GlobalKey get getKey {
    return _key;
  }

  TextEditingController get getPhoneTED {
    return _phoneNoTED;
  }
}
