import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/new_register_controller/new_enter_details_controller.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_registration_field.dart';

class NewEnterUserDetailsScreen extends StatefulWidget {
  final String phoneNo;

  const NewEnterUserDetailsScreen({Key? key, required this.phoneNo})
      : super(key: key);

  @override
  _NewEnterUserDetailsScreenState createState() =>
      _NewEnterUserDetailsScreenState();
}

class _NewEnterUserDetailsScreenState extends State<NewEnterUserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<NewEnterUserDetailsScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: controller.getKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 38,
              ),
              Text(
                'Enter personal details',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 16,
              ),
              CustomRegistrationField(
                controller: controller.getNameTED,
                keyboardType: TextInputType.text,
                validator: (v) => controller.validateName(v),
                onSave: (v) => controller.onSaveName(v),
                label: 'Name',
                hint: 'name',
                icon: Icon(Icons.person),
              ),
              SizedBox(
                height: 16,
              ),
              CustomRegistrationField(
                controller: controller.getEmailTED,
                keyboardType: TextInputType.text,
                validator: (v) => controller.validateEmailFields(v),
                onSave: (v) => controller.onEmailSave(v),
                label: 'Email',
                hint: 'abc@demo.com',
                icon: Icon(Icons.email),
              ),
              SizedBox(
                height: 16,
              ),
              CustomRegistrationField(
                controller: controller.getReferCodeTED,
                keyboardType: TextInputType.text,
                // validator: (v) => controller.validateEmailFields(v),
                onSave: (v) => controller.onSaveReferCode(v),
                label: 'Referral code',
                hint: '',
                icon: Icon(Icons.supervisor_account),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () =>
                    controller.onContinueButtonPressed(context, widget.phoneNo),
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
      ),
    );
  }
}
