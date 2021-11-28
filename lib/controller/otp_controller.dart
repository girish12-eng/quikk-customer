import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/helper.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/screens/new_register_flow/new_enter_user_details_screen.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends ChangeNotifier {
  late SharedPreferences _preferences;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isCodeSent = false;
  late String _verificationId;
  TextEditingController pinEditingController = TextEditingController();
  String? phone;

  void init() {
    pinEditingController.text = '';
  }

  Future<void> onVerifyCode(BuildContext context, String phoneNo) async {
    print('i am verifycode');
    Fluttertoast.showToast(msg: 'Sending verification code');
    phone = phoneNo;
    void verificationDone(PhoneAuthCredential credential) async {
      await _firebaseAuth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          print('i auto verify');
          var res = await checkIfLoginRepo(phone: phone);
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          if (res != null) {
            await setDeviceTokenRepo(res.token, fcmToken!);
            _preferences = await SharedPreferences.getInstance();
            _preferences.setString('token', res.token!);
            _preferences.setString('name', res.data!.name!);
            _preferences.setString('email', res.data!.email!);
            _preferences.setString('phone', res.data!.phone!);
            // Navigator.pop(context);
            pushNewScreen(
              context,
              screen: BottomNavigationScreen(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewEnterUserDetailsScreen(
                  phoneNo: phone!,
                ),
              ),
            );
          }
        } else {
          Fluttertoast.showToast(msg: "Error validating OTP, try again");
        }
      }).catchError((error) {
        print('verify done error' + error);
        Fluttertoast.showToast(msg: '$error');
      });
    }

    void verificationFail(FirebaseAuthException e) {
      print('i am fail' + e.message.toString());
      Fluttertoast.showToast(msg: '${e.message}');
    }

    void codeSent(String verificationId, int? resendToken) async {
      print('i am code Sent');
      Fluttertoast.showToast(msg: 'Verification code send successfully');
      _verificationId = verificationId;
      // dialogBox(verificationId, resendToken);
      // Create a PhoneAuthCredential with the code
    }

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _firebaseAuth
        .verifyPhoneNumber(
      phoneNumber: "+91$phoneNo",
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationDone,
      verificationFailed: verificationFail,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    )
        .catchError((error) {
      print('verifyPhoneNo' + error);
      Fluttertoast.showToast(msg: '$error');
    });
  }

  void onFormSubmitted(BuildContext context) async {
    Helper.showLoadingDialog(context);
    try {
      AuthCredential _authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: pinEditingController.text);
      var response = await _firebaseAuth.signInWithCredential(_authCredential);

      if (response.user != null) {
        print('i verify');
        var res = await checkIfLoginRepo(phone: phone);
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (res != null) {
          await setDeviceTokenRepo(res.token, fcmToken!);
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewEnterUserDetailsScreen(
                phoneNo: phone!,
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Invalid OTP');
      } else if (e.code == 'invalid-verification-id') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Invalid OTP');
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Something went wrong,please try again later');
      }
    }
  }
}
