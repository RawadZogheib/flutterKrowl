import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/models/chat_users.dart';
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/CreatePostContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';

import 'Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CreateTable(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Wrap(
                                children: [
                                  Column(children: globals.children,)],
                              ),
                              SizedBox(width: 20),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Wrap(
                                children: [
                                  Column(children: globals.children,)],
                              ),
                              SizedBox(width: 20),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          desktop: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabBar(),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        totalRepeatCount: 5,
                        animatedTexts: [
                          WavyAnimatedText('Ask a question ?'),
                        ],
                        isRepeatingAnimation: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 600,
                    height: 600,
                    color: globals.blue2,
                  ),
                  List<
                  ChatUsers(text: 'eeewg', secondaryText: 'fdsfk', image: "Assets/userImage6.jpeg", time: "17 Mar")
                ],
              ),

            ]),
          ),
        ));
  }
}



