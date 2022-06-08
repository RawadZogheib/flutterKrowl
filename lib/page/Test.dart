import 'package:Krowl/widgets/Settings/SettingsContainer.dart';
import 'package:Krowl/widgets/Students/StudentProfile/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String _firstName = "Clara";
  String _lastName = "Zeidan";
  String _username = "ClaraZ1";
  String _emailAddress = "Clarazeidan@outlook.com";
  String _bio = "Graduated from McGill University. Currently working as a software engineer for Le Wagon - Co-founder of Krowl";
  // String _firstName = "Clara";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 500, height: 300,),
            myProfile(userId: 1, username: "Clara", universityName: "Lebanese University", description:"I am clara ", isFriend: "blue", nbrOfFriends: 15),
          ],
        ),
      ),
    );
  }
}
