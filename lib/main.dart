import 'package:flutter/material.dart';
import 'package:Krowl/page/Reminders.dart';
import 'package:Krowl/page/Students/Students1.dart';
import 'package:Krowl/widgets/Chat/components/streamChatFriends.dart';
import 'package:Krowl/page/Code.dart';
import 'package:Krowl/page/Forum/Forum1.dart';
import 'package:Krowl/page/Forum/Forum2.dart';
import 'package:Krowl/page/Library.dart';
import 'package:Krowl/page/Login/login.dart';
import 'package:Krowl/page/Login/login2.dart';
import 'package:Krowl/page/MainChat.dart';
import 'package:Krowl/page/Forum/ReplyPage.dart';
import 'package:Krowl/page/Signup/Registration.dart';
import 'package:Krowl/page/Signup/Registration2.dart';
import 'package:Krowl/page/Signup/Registration3.dart';
import 'package:Krowl/page/Signup/Signup.dart';
import 'package:Krowl/page/Signup/Signup2.dart';
import 'package:Krowl/page/Test.dart';
import 'package:Krowl/page/intro_page.dart';
import 'package:Krowl/page/intro_page2.dart';
import 'package:Krowl/page/videoConference.dart';
import 'package:Krowl/page/videoConference2.dart';
import 'package:Krowl/page/FirstPage.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: Intro(),
          initialRoute: '/FirstPage',
          routes: {
            '/FirstPage': (context) => FirstPage(),
            '/intro_page': (context) => Intro(),
            '/login': (context) => Login(),
            '/login2': (context) => Login2(),
            '/Code': (context) => Code(),
            '/intro_page2': (context) => Intro2(),
            '/Signup': (context) => Signup(),
            '/Signup2': (context) => Signup2(),
            '/Registration': (context) => Registration(),
            '/Registration2': (context) => Registration2(),
            '/Registration3': (context) => Registration3(),
            '/Library': (context) => Library(),
            '/Test': (context) => Test(),
            '/VideoConference': (context) => VideoConference(),
            '/MainChat': (context) => MainChat(),
            '/VideoConference2': (context) => VideoConference2(),
            '/Forum1': (context) => Forum1(),
            '/Forum2': (context) => Forum2(),
            '/Students1': (context) => Students1(),
            '/Reminders': (context) => Reminders()
            //'/ReplyPage': (context) => ReplyPage(),
          });
    });
  }
}
