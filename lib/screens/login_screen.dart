import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/login_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/registration/registration_screen.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginScreenController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .8,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(64)),
                color: Colors.black,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .8 - 20,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(Constant.KPrimaryColor),
                  ),
                ),
                onPressed: () => controller.onLoginButtonPressed(context),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            Positioned(
              top: 64,
              child: Image.asset(
                Constant.KAsset + 'logo.png',
                width: 200,
              ),
            ),
            Positioned(
              top: 250,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 32),
                  child: Form(
                    key: controller.getFOrmKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          color: Colors.white,
                          width: 32,
                          height: 2,
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        Container(
                          child: TextFormField(
                            controller: controller.getEmailTED,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            validator: (v) => controller.validateFields(v!),
                            onSaved: (v) => controller.onSaveEmailTED(v!),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.all(12),
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          child: TextFormField(
                            controller: controller.getPasswordTED,
                            validator: (v) => controller.validateFields(v!),
                            onSaved: (v) => controller.onSavePasswordTED(v!),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: '••••••••••••',
                                contentPadding: EdgeInsets.all(12),
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .1,
              child: GestureDetector(
                // onTap: () => _controller.showBottomSheet(context),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .050,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrationScreen(),
                  ),
                ),
                child: Text(
                  'I dont have account?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
