import 'package:flutter/material.dart';
import 'package:flutter_app_backend/page/Registration2.dart';
import 'package:flutter_app_backend/page/login.dart';
import 'package:flutter_app_backend/page/login2.dart';
import 'package:flutter_app_backend/page/Code.dart';
import 'package:flutter_app_backend/page/intro_page.dart';
import 'package:flutter_app_backend/page/intro_page2.dart';
import 'package:flutter_app_backend/welcome/welcome_page.dart';
import 'package:flutter_app_backend/page/Signup.dart';
import 'package:flutter_app_backend/page/no_secret_code2.dart';
import 'package:flutter_app_backend/page/Signup2.dart';
import 'package:flutter_app_backend/page/Registration.dart';
import 'package:flutter_app_backend/page/Registration2.dart';
import 'package:flutter_app_backend/page/Registration3.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
        initialRoute: '/intro_page',
        routes: {
          '/intro_page': (context) => Intro(),
          '/login': (context) => Login(),
          '/login2': (context) =>Login2(),
          '/Code': (context) => Code(),
          '/intro_page2': (context) => Intro2(),
          '/Signup': (context) => Signup(),
          '/no_secret_code2': (context) => Nosecretcode2(),
          '/Signup2': (context) => Signup2(),
          '/Registration': (context) => Registration(),
          '/Registration2': (context) => Registration2(),
          '/Registration3': (context) => Registration3(),

        }
    );});
  }
}
