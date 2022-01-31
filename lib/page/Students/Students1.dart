import 'dart:async';
import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum2/Contributors.dart';
import 'package:flutter_app_backend/widgets/Students/StudentCard.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Students1()));

class Students1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Students1> createState() => _Students1State();
}

class _Students1State extends State<Students1> with SingleTickerProviderStateMixin {
  @override
  var children = <Widget>[]; // Posts

  @override
  void initState() {
    super.initState();
    setState(() {
      children.add(StudentCard(universityname: "Lebanese University", username: "Rawad Zogheib", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Dana Mourany", isFriend: true));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: false));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true));
      children.add(StudentCard(universityname: "Lebanese University", username: "Rawad Zogheib", isFriend: true));
      children.add(StudentCard(universityname: "Lebanese University", username: "Dana Mourany", isFriend: true));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: false));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Rawad Zogheib", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Dana Mourany", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Rawad Zogheib", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Dana Mourany", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true,));
      children.add(StudentCard(universityname: "Lebanese University", username: "Clara Zeidan", isFriend: true,));
    });
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: false,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBar(hintText: "Search for students..."),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: children, // My Children
                ),
              ],
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SearchBar(hintText: "Search for students..."),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: children, // My Children
                    ),
                  ],
                ),
              ],
            ),
          ),
          desktop: SingleChildScrollView(
            reverse: false,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabBar(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SearchBar(hintText: "Search for students..."),
                      SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          alignment: Alignment.center,
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: children, // My Children
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
