import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/select_signup_login_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/login_screen.dart';
import 'package:quikk_customer/screens/registration/registration_screen.dart';

class SelectSignupLoginScreen extends StatefulWidget {
  const SelectSignupLoginScreen({Key? key}) : super(key: key);

  @override
  _SelectSignupLoginScreenState createState() =>
      _SelectSignupLoginScreenState();
}

class _SelectSignupLoginScreenState extends State<SelectSignupLoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SelectSignupLoginScreenController>(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Image.asset(
              Constant.KAsset + 'front5.jpg',
              height: MediaQuery.of(context).size.height * .6,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                color: Color(0xffFCF3CA),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () =>
                                      controller.onPhoneButtonPressed(context),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Text('Continue with phone'),
                                  ),
                                  icon: Icon(Icons.phone),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () =>
                              controller.onTermServiceButtonPressed(context),
                          child: Column(
                            children: [
                              Text('By continue, you agree to our'),
                              Text(
                                'Terms of Service & Privacy Policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                        // ElevatedButton.icon(
                        //   icon: Image.asset(
                        //     Constant.KAsset + 'google.png',
                        //     width: 32,
                        //     height: 32,
                        //   ),
                        //   style: ButtonStyle(
                        //       backgroundColor:
                        //           MaterialStateProperty.all(Colors.white)),
                        //   onPressed: () {},
                        //   label: Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 8),
                        //     child: Text(
                        //       'Continue with google',
                        //       style:
                        //           Theme.of(context).textTheme.subtitle1!.copyWith(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
//
// Column(
// children: [
// ElevatedButton(
// onPressed: () => Navigator.push(
// context,
// MaterialPageRoute(
// builder: (_) => LoginScreen(),
// ),
// ),
// child: Text('Login'),
// ),
// ElevatedButton(
// onPressed: () => Navigator.push(
// context,
// MaterialPageRoute(
// builder: (_) => RegistrationScreen(),
// ),
// ),
// child: Text('Signup'),
// ),
// ElevatedButton(
// onPressed: () => _handleSignIn(),
// child: Text('Google'),
// ),
// ],
// ),
