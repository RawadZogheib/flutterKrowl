import 'package:flutter/material.dart';
import 'package:flutter_app_backend/page/Sign_up.dart';
import 'package:flutter_app_backend/page/Sign_up2.dart';
import 'package:flutter_app_backend/page/intro_page.dart';
import 'package:flutter_app_backend/page/intro_page2.dart';
import 'package:flutter_app_backend/welcome/welcome_page.dart';
import 'package:flutter_app_backend/page/no_secret_code.dart';
import 'package:flutter_app_backend/page/no_secret_code2.dart';
import 'package:flutter_app_backend/page/Uni_has_secret_code.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          '/Sign_up': (context) => Signup(),
          '/Sign_up2': (context) => Signup2 (),
          '/intro_page2': (context) => Intro2(),
          '/no_secret_code': (context) => Nosecretcode(),
          '/no_secret_code2': (context) => Nosecretcode2(),
          '/Uni_has_secret_code': (context) => Hassecretcode2(),
        }
    );
  }
}
