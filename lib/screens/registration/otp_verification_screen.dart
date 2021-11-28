import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/otp_controller.dart';
import 'package:quikk_customer/models/user_model.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final UserModel user;

  const OtpVerificationScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OtpController>(context, listen: false).onVerifyCode(
      context,
      widget.user.phone!,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    var controller = Provider.of<OtpController>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // backgroundColor: Constants.APP_COLOR,
          elevation: 0,
          leading: CustomBackButton(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: size.height - padding.top - padding.bottom - 70,
              color: Colors.white,
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/phone.gif',
                      ),
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Text(
                      'OTP Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Roboto-Bold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffA0A0A0),
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Enter the OTP send to '),
                            TextSpan(
                              text: ' ${widget.user.phone!}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: PinInputTextField(
                            pinLength: 6,
                            decoration: BoxLooseDecoration(
                              textStyle: Theme.of(context).textTheme.subtitle2,
                              strokeColorBuilder: PinListenColorBuilder(
                                  Colors.cyan, Colors.green),
                            ),
                            controller: controller.pinEditingController,
                            autoFocus: true,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.onVerifyCode(context, widget.userModel);
                            Fluttertoast.showToast(msg: 'Resend code success');
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffA0A0A0),
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Dont recieve the OTP ? '),
                                  TextSpan(
                                    text: 'RESEND OTP',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFF8467),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        // ElevatedButton(
                        //     child: Text('VERIFY & PROCEED'),
                        //     // color: MaterialStateProperty.all<Color>(
                        //     //     Constants.KPurpleColor),
                        //     onPressed: () {
                        //       controller.onFormSubmitted(context, widget.user);
                        //     })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
