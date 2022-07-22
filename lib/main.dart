//import 'dart:html'; // add for web

import 'package:Krowl/page/CodeLog.dart';
import 'package:Krowl/page/CodeReg.dart';
import 'package:Krowl/page/FirstPage.dart';
import 'package:Krowl/page/ForgetPassword/forgetPassword.dart';
import 'package:Krowl/page/ForgetPassword/forgetPassword2.dart';
import 'package:Krowl/page/Forum/Forum1.dart';
import 'package:Krowl/page/Forum/Forum2.dart';
import 'package:Krowl/page/Library.dart';
import 'package:Krowl/page/Login/login.dart';
import 'package:Krowl/page/Login/login2.dart';
import 'package:Krowl/page/MainChat.dart';
import 'package:Krowl/page/Notifications.dart';
import 'package:Krowl/page/Reminders.dart';
import 'package:Krowl/page/Settings.dart';
import 'package:Krowl/page/Signup/Registration.dart';
import 'package:Krowl/page/Signup/Registration2.dart';
import 'package:Krowl/page/Signup/Registration3.dart';
import 'package:Krowl/page/Signup/Signup.dart';
import 'package:Krowl/page/Signup/Signup2.dart';
import 'package:Krowl/page/Students/Students1.dart';
import 'package:Krowl/page/Test.dart';
import 'package:Krowl/page/intro_page.dart';
import 'package:Krowl/page/intro_page2.dart';
import 'package:Krowl/page/videoConference.dart';
import 'package:Krowl/page/videoConference2.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:sizer/sizer.dart';

String? arg; //initial value

void main(List<String> args) { // remove for web 'List<String> args'
  debugPrint('args: $args'); // remove for web
  if (runWebViewTitleBarWidget(args)) { // remove for web
    return; // remove for web
  } // remove for web
  WidgetsFlutterBinding.ensureInitialized(); // remove for web
  //load(); // add for web
  runApp(MyApp());
}

// load() async { // add for web
//   var uri = Uri.dataFromString(window.location.href); // add for web
//   Map<String, String> params = uri.queryParameters; // add for web
//
//   if (params["private"] != null) { // add for web
//     arg = params["private"].toString(); // add for web
//     print("ARG NOT EMPTY" + arg!); // add for web
//     SessionManager().remove("arg"); // add for web
//     await SessionManager().set("arg", arg); // add for web
//   } // add for web
// } // add for web

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Krowl',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: Intro(),
          initialRoute: '/FirstPage',
          routes: {
            '/FirstPage': (context) => FirstPage(),
            '/?private=' + arg.toString(): (context) => FirstPage(),
            '/intro_page': (context) => Intro(),
            '/login': (context) => Login(),
            '/login2': (context) => Login2(),
            '/CodeReg': (context) => CodeReg(),
            '/CodeLog': (context) => CodeLog(),
            '/intro_page2': (context) => Intro2(),
            '/Signup': (context) => Signup(),
            '/Signup2': (context) => Signup2(),
            '/Registration': (context) => Registration(),
            '/Registration2': (context) => Registration2(),
            '/Registration3': (context) => Registration3(),
            '/Library': (context) => Library(),
            // '/Test': (context) => Test(),
            //'/VideoConference': (context) => VideoConference(),
            '/MainChat': (context) => MainChat(),
            //'/VideoConference2': (context) => VideoConference2(),
            '/Forum1': (context) => Forum1(),
            '/Forum2': (context) => Forum2(),
            '/Students1': (context) => Students1(),
            '/Reminders': (context) => Reminders(),
            '/forgetPass': (context) => forgetPass(),
            '/forgetPass2': (context) => forgetPass2(),
            '/Settings': (context) => Settings(),
            '/Notifications': (context) => Notifications(),
            //'/ReplyPage': (context) => ReplyPage(),
          });
    });
  }
}
