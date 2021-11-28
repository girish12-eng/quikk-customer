import 'package:flutter/material.dart';
import 'package:quikk_customer/controller/new_register_controller/new_enter_phone_no_screen.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class NewEnterPhoneNoScreen extends StatefulWidget {
  const NewEnterPhoneNoScreen({Key? key}) : super(key: key);

  @override
  _NewEnterPhoneNoScreenState createState() => _NewEnterPhoneNoScreenState();
}

class _NewEnterPhoneNoScreenState extends State<NewEnterPhoneNoScreen> {
  final _controller = NewEnterPhoneNoScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _controller.getKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 38,
              ),
              Text(
                'Enter your mobile number',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 16,
              ),
              // Text(
              //   'lorenn ipsiumnn',
              //   style: Theme.of(context).textTheme.bodyText1,
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              ListTile(
                leading: Text(
                  '+91',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                title: TextFormField(
                  controller: _controller.getPhoneTED,
                  validator: (v) => _controller.validatePhone(v!),
                  onSaved: (v) => _controller.onSavePhoneNo(v!),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffEEEFF1), width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffEEEFF1), width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Phone Number',
                    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black38,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () => _controller.onSendCodeButtonPressed(context),
                child: Text(
                  'Send code',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
