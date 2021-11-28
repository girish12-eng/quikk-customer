import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quikk_customer/models/user_model.dart';
import 'package:quikk_customer/screens/registration/otp_intro_screen.dart';

class RegistrationController extends ChangeNotifier {
  TextEditingController userNameNoTED = TextEditingController();
  TextEditingController emailTED = TextEditingController();
  TextEditingController phoneNoTED = TextEditingController();
  TextEditingController passwordNoTED = TextEditingController();
  TextEditingController passwordAgainNoTED = TextEditingController();
  TextEditingController addressTED = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String? validateUserNameFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (v.length <= 6) return 'Minimum 6 word is required';
    return null;
  }

  String? validateEmailFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v)) return 'Please enter valid email';
    return null;
  }

  String? validatePhoneNoFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (v.length != 10) return 'Please enter valid phone no';
    return null;
  }

  String? validatePasswordFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (v.length <= 6) return 'Minimum 6 word is required';
    return null;
  }

  String? validatePasswordAgainFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (v != passwordNoTED.text) return 'Password not matching';
    return null;
  }

  void onSaveUserName(String v) {
    userNameNoTED.text = v;
  }

  void onEmailSave(String v) {
    emailTED.text = v;
  }

  void onSavePhone(String v) {
    phoneNoTED.text = v;
  }

  void onSavePassword(String v) {
    passwordNoTED.text = v;
  }

  void onSaveConfirmPassword(String v) {
    passwordAgainNoTED.text = v;
  }

  void onSaveAddress(String v) {
    addressTED.text = v;
  }

  void onSubmitPressed(BuildContext context) {
    print('i called');
    if (key.currentState!.validate()) {
      key.currentState!.save();
      UserModel user = UserModel();
      user.username = userNameNoTED.text;
      user.email = emailTED.text;
      user.phone = phoneNoTED.text;
      user.password = passwordNoTED.text;
      user.confirmPassword = passwordAgainNoTED.text;
      user.address = addressTED.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpIntroScreen(
            user: user,
          ),
        ),
      );
      // OtpController controller = OtpController();
      // controller.onVerifyCode(context, phoneNoTED.text);
    }
  }
}
