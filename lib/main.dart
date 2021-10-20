import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:time_catcher/Screens/FirstTimeScreen.dart';
import 'package:time_catcher/Screens/RegistrationScreens/login_screen.dart';
import 'package:time_catcher/Screens/SplashScreen.dart';
import 'package:time_catcher/Screens/TopThree/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Catcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "SplashScreen": (BuildContext context) => SplashScreen(),
        "WelcomeScreen": (BuildContext context) => WelcomeScreen(),
        "MainScreen": (BuildContext context) => MainScreen(),
        "LoginScreen": (BuildContext context) => LoginScreen(),
      },
      home: SplashScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
