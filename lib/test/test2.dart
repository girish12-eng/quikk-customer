import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:quikk_customer/test/test3.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class Test2EnterOtpScreenPhoneLogin extends StatelessWidget {
  static const id = 'EnterOtpScreenPhoneLogin';

  const Test2EnterOtpScreenPhoneLogin({Key? key}) : super(key: key);

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black12),
      color: Color(0xffEBEDF1),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
              'We sent a a 4-digit code to +1 (305) 1234 567. To validate your account insert this code below.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 24,
            ),
            PinPut(
              fieldsCount: 6,
              // onSubmit: (String pin) => _showSnackBar(pin, context),
              // focusNode: _pinPutFocusNode,
              // controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Test3EnterPersonalScreen(),
                ),
              ),
              child: Text('Resend code (00:29)'),
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all(
              //     CustomColor.KPrimaryColor.withOpacity(.5),
              //   ),
              // ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Test3EnterPersonalScreen(),
                ),
              ),
              child: Text('Continue'),
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all(
              //     CustomColor.KPrimaryColor.withOpacity(.5),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
