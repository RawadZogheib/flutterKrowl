import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/AskQuestion.dart';
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/TopContributors.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  late TabController tabController;
  List<ContentView> contentViews = [
    ContentView(
        tab: CustomTab(title: 'Library'),
        content: Center(
          child: Container(
            color: Colors.black,
            width: 90,
            height: 100,
          ),
        )),
    ContentView(
        tab: CustomTab(title: 'Chats'),
        content: Center(
          child: Container(),
        )),
    ContentView(
        tab: CustomTab(title: 'Forum'),
        content: Center(
          child: Container(),
        )),
    ContentView(
        tab: CustomTab(title: 'Students'),
        content: Center(
          child: Container(),
        )),
    ContentView(
        tab: CustomTab(title: 'Reminders'),
        content: Center(
          child: Container(),
        )),
  ];

  bool toggleValue = false;
  late AnimationController controller;

  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
      setState(() {});
    });
    controller.stop(canceled: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    toggleButton() async {
      setState(() {
        toggleValue = !toggleValue;

      });
      if(toggleValue == true){
        controller.repeat(reverse: false);
        await Future.delayed(const Duration(seconds: 10), (){
          controller.stop();
        });
      }else{
        controller.reset();
      }
    }
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            height:30,
            width: 80,
            duration: Duration(milliseconds: 1000),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: toggleValue
                    ? Colors.blue.shade900
                    : Colors.blue.shade100),
            child: Stack(
                children: [
            AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            top: 3.0,
            left: toggleValue ? 50.0 : 0.0,
            right: toggleValue ? 5.0 : 60.0,
            child: InkWell(
              onTap: toggleButton,
              child: AnimatedSwitcher(duration: Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(child: child,
                turns: animation,);
                },
                child: toggleValue? Icon(Icons.lightbulb, color: Colors.yellow, size: 25, key: UniqueKey(),):
                Icon(Icons.lightbulb_outline_sharp, color: Colors.white, size: 25, key: UniqueKey(),),
              ),
            ),)
            ],
          ),),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                  color: globals.blue1,
                  backgroundColor: globals.blue2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
