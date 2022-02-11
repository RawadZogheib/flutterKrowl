import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';

import '../widgets/Students/StudentProfile/ProfileQuestions&Replies.dart';
import '../widgets/Students/StudentProfile/StudentDetailedProfileContainer.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTabBar(),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StudentDetailedProfile(isFriend: false, universityname: "Lebanese Universty", username:"Rawad Zogheib", description: "No description provided",  ),
                  SizedBox(height: 15,),
                  StudentQuestionsReplies(),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
