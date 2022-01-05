import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/CreatePostContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';

import '../Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Forum2()));

class Forum2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Forum2> createState() => _Forum2State();
}

class _Forum2State extends State<Forum2> with SingleTickerProviderStateMixin {


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
              CustomTabBar(),
              Container(
                height: 800,
                color: globals.blue1.withOpacity(0.98),
                alignment: Alignment.center,
                child: Row(
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
                      width: 520,
                      height: 520,
                      decoration: BoxDecoration(
                        color: globals.blue2,
                        borderRadius: BorderRadius.circular(5),
                   
                      ),
                    )
                  ],
                ),
              ),

            ]),
          ),
        ));
  }
}



