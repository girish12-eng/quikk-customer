import 'package:flutter/material.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_registration_field.dart';

class Test3EnterPersonalScreen extends StatelessWidget {
  // Test3EnterPersonalScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Enter personal details',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            CustomRegistrationField(
              controller: controller,
              keyboardType: TextInputType.text,
              // validator: (v) =>
              //     controller.validateUserNameFields(v),
              // onSave: (v) => controller.onSaveUserName(v),
              label: 'UserName',
              hint: 'UserName',
              icon: Icon(Icons.person),
            ),
            SizedBox(
              height: 16,
            ),
            CustomRegistrationField(
              controller: controller,
              keyboardType: TextInputType.text,
              // validator: (v) =>
              //     controller.validateUserNameFields(v),
              // onSave: (v) => controller.onSaveUserName(v),
              label: 'Email',
              hint: 'abc@demo.com',
              icon: Icon(Icons.person),
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
