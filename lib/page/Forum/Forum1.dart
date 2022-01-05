import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';

import '../Responsive.dart';


void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum1()));

class Forum1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum1> createState() => _Forum1State();
}

class _Forum1State extends State<Forum1> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

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
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
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
                  CustomTabBar(
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BouncingWidget(
                            duration: Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            onPressed: () {
                              print("onPressed");
                            },
                            child: Text(
                              "Forum",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 430,
                          ),
                          AskQuestionButton(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SearchBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Question(),
                      SizedBox(
                        height: 20,
                      ),
                      Question(),
                      SizedBox(
                        height: 20,
                      ),
                      Question(),
                      SizedBox(
                        height: 20,
                      ),
                      Question(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Contributors(),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}



