import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/CustomTab.dart';
import 'package:flutter_app_backend/widgets/CustomTabBar.dart';
import 'package:flutter_app_backend/widgets/QuietTable.dart';
import 'package:flutter_app_backend/widgets/SilentTable.dart';
import 'package:desktop_window/desktop_window.dart';


void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Library()));

class Library extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Library> createState() => _TestState();
}

class _TestState extends State<Library> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<ContentView> contentViews = [
    ContentView(tab: CustomTab(title: 'Library'), content: Center(
      child: Container(color: Colors.black, width: 90, height: 100,),
    )),
    ContentView(tab: CustomTab(title: 'Chats'), content: Center(
      child: Container(),
    )),
    ContentView(tab: CustomTab(title: 'Forum'), content: Center(
      child: Container(),
    )),
    ContentView(tab: CustomTab(title: 'Students'), content: Center(
      child: Container(),
    )),
    ContentView(tab: CustomTab(title: 'Reminders'), content: Center(
      child: Container(),
    )),
  ];
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    DesktopWindow.setMinWindowSize(Size(500, 800));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.white,
      body: Responsive(mobile:
      SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateRoom(),
              Column(
                  children: [
                    SilentTable(text: "Room name",),
                    QuietTable(text: "Room name",),
                    SizedBox(width: 20,),
                  ]
              ),

            ],
          ),
        ),
      ),
        tablet:
        SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateRoom(),
              Column(
                  children: [
                    QuietTable(text: "Room name",),
                    QuietTable(text: "Room name",),
                    SizedBox(width: 20,),
                  ]
              ),

            ],
          ),
      ), desktop: SingleChildScrollView(
        reverse: true,
        child:Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('Assets/krowl_logo.png'),
              width: 200,
              height: 200,
            ),
            SizedBox(width: 200 ,),
            CustomTabBar(
              controller: tabController,
              tabs: contentViews.map((e) => e.tab).toList(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: _size.width > 1100?  1:2,
                child: CreateRoom()
            ), Expanded(
              flex: _size.width > 1100? 2:6,
              child: Row(
                  children: [
                    SilentTable(text: "Room name",),
                    QuietTable(text: "Room name",),
                    SizedBox(width: 20),
                  ]
              ),
            ),

          ],
        ),]),
      ),)
    );
  }
}
