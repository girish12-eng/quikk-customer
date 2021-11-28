import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/registration_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/widgets/custom_registration_field.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RegistrationController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(color: Colors.black),
              ),
              Positioned(
                top: 64,
                left: 16,
                child: Text(
                  'REGISTRATION',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                top: 59,
                right: 16,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'back to login',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: controller.key,
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomRegistrationField(
                                controller: controller.userNameNoTED,
                                keyboardType: TextInputType.text,
                                validator: (v) =>
                                    controller.validateUserNameFields(v),
                                onSave: (v) => controller.onSaveUserName(v),
                                label: 'UserName',
                                hint: 'UserName',
                                icon: Icon(Icons.person),
                              ),
                              CustomRegistrationField(
                                controller: controller.emailTED,
                                validator: (v) =>
                                    controller.validateEmailFields(v),
                                onSave: (v) => controller.onEmailSave(v),
                                keyboardType: TextInputType.text,
                                label: 'Email Address',
                                hint: 'abc@cdf.com',
                                icon: Icon(Icons.email),
                              ),
                              CustomRegistrationField(
                                validator: (v) =>
                                    controller.validatePhoneNoFields(v),
                                onSave: (v) => controller.onSavePhone(v),
                                label: 'Phone Number',
                                hint: '5588774455',
                                controller: controller.phoneNoTED,
                                keyboardType: TextInputType.number,
                                icon: Icon(Icons.phone),
                              ),
                              CustomRegistrationField(
                                validator: (v) =>
                                    controller.validatePasswordFields(v),
                                onSave: (v) => controller.onSavePassword(v),
                                label: 'Password',
                                hint: '*******',
                                controller: controller.passwordNoTED,
                                keyboardType: TextInputType.text,
                                icon: Icon(Icons.vpn_key),
                              ),
                              CustomRegistrationField(
                                validator: (v) =>
                                    controller.validatePasswordAgainFields(v),
                                onSave: (v) =>
                                    controller.onSaveConfirmPassword(v),
                                label: 'Confirm Password',
                                hint: '*******',
                                controller: controller.passwordAgainNoTED,
                                keyboardType: TextInputType.text,
                                icon: Icon(Icons.vpn_key),
                              ),
                              CustomRegistrationField(
                                onSave: (v) => controller.onSaveAddress(v),
                                label: 'Address',
                                hint: '',
                                controller: controller.addressTED,
                                keyboardType: TextInputType.text,
                                icon: Icon(Icons.home),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .8 + 38,
                child: GestureDetector(
                  onTap: () => controller.onSubmitPressed(context),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 10),
                              blurRadius: 8)
                        ]),
                    width: 80,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffFC707F),
                            Color(0xffA38431),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
