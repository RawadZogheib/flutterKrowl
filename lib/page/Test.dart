import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/QuestionContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/TopContributors.dart';
import 'package:flutter_app_backend/widgets/Library/Chairs.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:hovering/hovering.dart';




void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
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

  List<TopContributors> Users = [

    ];
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Image.asset('Assets/krowl_logo.png', scale: 2.0,), onTap: (){
                  Navigator.pushNamed(context, '/Library', );
                },),
                SizedBox(
                  width: 460,
                ),
                CustomTabBar(
                  controller: tabController,
                  tabs: contentViews.map((e) => e.tab).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 130,),

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
                     /* Text('Forum',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik',
                              color: Colors.black)),*/
                      SizedBox(width: 430,),
                      AskQuestionButton(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  SearchBar(),
                  SizedBox(height: 20,),
                  Question(),
                  SizedBox(height: 20,),
                  Question(),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  TopContributors(),
                ],
              ),
          ],
          ),
        ],
      ),
    );
  }
}

class Users {
  String text;
  var icon;
  Users({required this.text, this.icon});
}
