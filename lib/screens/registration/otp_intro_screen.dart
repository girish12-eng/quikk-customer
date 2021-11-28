import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quikk_customer/models/user_model.dart';
import 'package:quikk_customer/screens/registration/otp_verification_screen.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class OtpIntroScreen extends StatefulWidget {
  final UserModel user;

  const OtpIntroScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _OtpIntroScreenState createState() => _OtpIntroScreenState();
}

class _OtpIntroScreenState extends State<OtpIntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Constants.KGreyColor,
          elevation: 0,
          leading: CustomBackButton(),
        ),
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage('assets/images/llo.gif'),
                ),
                Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle1,
                      children: <TextSpan>[
                        TextSpan(text: 'We will send you an'),
                        TextSpan(
                          text: ' One Time Password ',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(text: 'on this mobile number'),
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mobile Number',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.phone!,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        child: Text('Verify And Proceed'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OtpVerificationScreen(
                                user: widget.user,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
