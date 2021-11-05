import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/LibraryWidgets/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/CustomTab.dart';
import 'package:flutter_app_backend/widgets/CustomTabBar.dart';
import 'package:flutter_app_backend/widgets/LibraryWidgets/CustomTable.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CreateRoom(),
                  SizedBox(height: 20,),
                  Column(children: [
                    CustomTable(text: "room name", text2: "room", color2: Colors.green)
                  ]),
                ],
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateRoom(),
                SizedBox(height: 20,),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                 CustomTable(text: "room name", text2: "room type", color2: Colors.red),
                      CustomTable(text: "room name", text2: "room type", color2: Colors.green)
                ]),
              ],
            ),
          ),
          desktop: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Assets/krowl_logo.png', scale: 2.0,),
                  SizedBox(
                    width: 200,
                  ), 
                  CustomTabBar(
                    controller: tabController,
                    tabs: contentViews.map((e) => e.tab).toList(),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                        CreateRoom(),
                    SizedBox(width: 20,),
                    CustomTable(text: "room name", text2: " room", color2: Colors.green,),
                    CustomTable(text: "room name", text2: "room type", color2: Colors.red),
                    SizedBox(width: 20),
                  ]),),

                ],
              ),
            ]),
          ),
        ));
  }
}
