import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/main.dart';
import 'package:quikk_customer/screens/select_signup_login_type.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends ChangeNotifier {
  late SharedPreferences _preferences;

  void init(BuildContext context) {
    initializeFcm();
    checkForLogin(context);
  }

  void initializeFcm() async {
    await FirebaseMessaging.instance
        .subscribeToTopic('global')
        .then((value) => print('sunscribedd'));
    String? token = await FirebaseMessaging.instance.getToken();
    print('fcm TOken');
    print(token);

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        print('inininttaalllll');
        print(value.data);
        // setState(() {
        //   data = value.data.toString();
        // });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('gggggggg');
      print('backgrount message aaya');
      print(message.notification!.body);
      print('gggggggg');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
            iOS: IOSNotificationDetails()
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  void checkForLogin(BuildContext context) async {
    _preferences = await SharedPreferences.getInstance();
    String? token = _preferences.getString('token');
    print(token);
    if (token != null) {
      Future.delayed(Duration(seconds: 2)).then((value) => pushNewScreen(
            context,
            screen: BottomNavigationScreen(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          ));
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => pushNewScreen(
          context,
          screen: SelectSignupLoginScreen(),
          withNavBar: false,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
      );
    }
  }
}
