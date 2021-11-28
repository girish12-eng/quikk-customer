import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/screens/my_account/help_support/help_support_screen.dart';
import 'package:quikk_customer/screens/new_register_flow/new_enter_phone_no_screen.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectSignupLoginScreenController extends ChangeNotifier {
  late SharedPreferences _preferences;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn().then((value) async {
        print(value?.id.toString());
        print(value?.email.toString());
        print(value?.displayName);
        print(value?.photoUrl);
        print(value?.id);
        var res = await checkIfLoginRepo(email: value?.email.toString());
        if (res != null) {
          _preferences = await SharedPreferences.getInstance();
          _preferences.setString('token', res.token!);
          _preferences.setString('name', res.data!.name!);
          _preferences.setString('email', res.data!.email!);
          _preferences.setString('phone', res.data!.phone!);
          Navigator.pop(context);
          pushNewScreen(
            context,
            screen: BottomNavigationScreen(),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void onPhoneButtonPressed(BuildContext context) {
    pushNewScreen(
      context,
      screen: NewEnterPhoneNoScreen(),
      withNavBar: false,
    );
  }

  void onGoogleButtonPressed() async {
    // await _handleSignIn();
  }

  void onTermServiceButtonPressed(BuildContext context) {
    pushNewScreen(
      context,
      screen: HelpSupportScreen(),
      withNavBar: false,
    );
  }
}
