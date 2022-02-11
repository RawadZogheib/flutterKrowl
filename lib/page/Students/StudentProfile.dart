import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/ProfileQuestions&Replies.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/StudentDetailedProfileContainer.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';


void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: StudentProfile()));

class StudentProfile extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
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
