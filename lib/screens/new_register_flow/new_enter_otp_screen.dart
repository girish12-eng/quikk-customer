import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/otp_controller.dart';
import 'package:quikk_customer/screens/new_register_flow/new_enter_user_details_screen.dart';
import 'package:quikk_customer/test/strategy.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class NewEnterOtpScreen extends StatefulWidget {
  final String phoneNO;

  const NewEnterOtpScreen({Key? key, required this.phoneNO}) : super(key: key);

  @override
  _NewEnterOtpScreenState createState() => _NewEnterOtpScreenState();
}

class _NewEnterOtpScreenState extends State<NewEnterOtpScreen> {
  int? time;
  late Timer timer;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black12),
      color: Color(0xffEBEDF1),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          time = time! - 1;
        });
      }
    });
    Provider.of<OtpController>(context, listen: false).onVerifyCode(
      context,
      widget.phoneNO,
    );
    Provider.of<OtpController>(context, listen: false).init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<OtpController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 38,
              ),
              Text(
                'Verify phone number',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'We sent a 6-digit code to +91${widget.phoneNO}. To verify your account insert this code below.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 24,
              ),
              PinPut(
                fieldsCount: 6,
                controller: controller.pinEditingController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                autovalidateMode: AutovalidateMode.always,
                selectedFieldDecoration: _pinPutDecoration,
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color(0xffEEEFF1),
                  ),
                ),
              ),
              SizedBox(
                height: 78,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Did not receive the code?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              time == 0
                  ? ElevatedButton(
                      onPressed: () async {
                        await controller.onVerifyCode(context, widget.phoneNO);
                        Fluttertoast.showToast(
                            msg: 'Verification code send successfully');
                        time = 60;
                        timer = Timer.periodic(Duration(seconds: 1), (timer) {
                          if (time == 0) {
                            setState(() {
                              timer.cancel();
                            });
                          } else {
                            setState(() {
                              time = time! - 1;
                            });
                          }
                        });
                      },
                      child: Text('Resend code'),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          border: Border.all(color: Colors.black12)),
                      child: Center(
                        child: Text(
                          'Resend code (00:$time)',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () => controller.onFormSubmitted(context),
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
