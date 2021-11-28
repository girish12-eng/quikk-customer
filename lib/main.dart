import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/bottom_nav_controller.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/controller/chat_controller/chatting_controller.dart';
import 'package:quikk_customer/controller/check_out_controller.dart';
import 'package:quikk_customer/controller/home_screen_controller.dart';
import 'package:quikk_customer/controller/login_screen_controller.dart';
import 'package:quikk_customer/controller/manage_address_controller.dart';
import 'package:quikk_customer/controller/market_by_category_controller.dart';
import 'package:quikk_customer/controller/market_screen_controller.dart';
import 'package:quikk_customer/controller/my_accout_screen_controller.dart';
import 'package:quikk_customer/controller/new_register_controller/new_enter_details_controller.dart';
import 'package:quikk_customer/controller/order_history_controller.dart';
import 'package:quikk_customer/controller/otp_controller.dart';
import 'package:quikk_customer/controller/registration_controller.dart';
import 'package:quikk_customer/controller/search_market_controller.dart';
import 'package:quikk_customer/controller/search_product_controller.dart';
import 'package:quikk_customer/controller/select_signup_login_controller.dart';
import 'package:quikk_customer/controller/splash_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quikk_customer/services/razor_pay.dart';

import 'controller/variationController.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await Firebase.initializeApp();
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // print(message.data);
  // if (notification != null && android != null) {
  //   flutterLocalNotificationsPlugin.show(
  //     2,
  //     message.data['yolo'],
  //     message.data['yolo'],
  //     NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'channel.id',
  //           'channel.name',
  //           'channel.description',
  //           // TODO add a proper drawable resource to android, for now using
  //           //      one that already exists in example app.
  //           icon: '@mipmap/ic_launcher',
  //         ),
  //         iOS: IOSNotificationDetails()),
  //   );
  // }
  print("Handling a background message: ${message.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashScreenController>(
          create: (_) => SplashScreenController(),
        ),
        ChangeNotifierProvider<SelectSignupLoginScreenController>(
          create: (_) => SelectSignupLoginScreenController(),
        ),
        ChangeNotifierProvider<RegistrationController>(
          create: (_) => RegistrationController(),
        ),
        ChangeNotifierProvider<LoginScreenController>(
          create: (_) => LoginScreenController(),
        ),
        ChangeNotifierProvider<OtpController>(
          create: (_) => OtpController(),
        ),
        ChangeNotifierProvider<HomeScreenController>(
          create: (_) => HomeScreenController(),
        ),
        ChangeNotifierProvider<MarketScreenController>(
          create: (_) => MarketScreenController(),
        ),
        ChangeNotifierProvider<OrderHistoryController>(
          create: (_) => OrderHistoryController(),
        ),
        ChangeNotifierProvider<CartController>(
          create: (_) => CartController(),
        ),
        ChangeNotifierProvider<CheckOutController>(
          create: (_) => CheckOutController(),
        ),
        ChangeNotifierProvider<ManageAddressController>(
          create: (_) => ManageAddressController(),
        ),
        ChangeNotifierProvider<MyAccountScreenController>(
          create: (_) => MyAccountScreenController(),
        ),
        ChangeNotifierProvider<RazorPayService>(
          create: (_) => RazorPayService(),
        ),
        ChangeNotifierProvider<SearchMarketController>(
          create: (_) => SearchMarketController(),
        ),
        ChangeNotifierProvider<MarketByCategoryController>(
          create: (_) => MarketByCategoryController(),
        ),
        ChangeNotifierProvider<SearchProductController>(
          create: (_) => SearchProductController(),
        ),
        ChangeNotifierProvider<NewEnterUserDetailsScreenController>(
          create: (_) => NewEnterUserDetailsScreenController(),
        ),
        ChangeNotifierProvider<ChattingController>(
          create: (_) => ChattingController(),
        ),
        ChangeNotifierProvider<BottomNavController>(create: (_) => BottomNavController(),),
        // ChangeNotifierProvider<VariationController>(create: (_) => VariationController(),),
      ],
      child: MaterialApp(
        title: 'Quikk',
        // scrollBehavior: ScrollBehavior()
        // ..buildOverscrollIndicator(context,_,ScrollableDetails(direction: direction, controller: controller)),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          cursorColor: Colors.grey[400],
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.sourceSansProTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(Constant.KSecondaryColor),
              ),
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.green,
                    ),
              ),
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
