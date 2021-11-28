import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/my_account/help_support/web_view.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(
          'HELP & SUPPORT',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'LEGAL',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              tileColor: Colors.white,
              title: Text(
                'Terms & Conditions',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => pushNewScreen(
                context,
                screen: WebViewMobileScreen(
                  url: 'https://quikkdelivery.com/mobileterms',
                ),
                withNavBar: false,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              tileColor: Colors.white,
              title: Text(
                'Return Policies',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => pushNewScreen(
                context,
                screen: WebViewMobileScreen(
                  url: 'https://quikkdelivery.com/mobilereturns',
                ),
                withNavBar: false,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              tileColor: Colors.white,
              title: Text(
                'Privacy',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => pushNewScreen(
                context,
                screen: WebViewMobileScreen(
                  url: 'https://quikkdelivery.com/mobileprivacy',
                ),
                withNavBar: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
