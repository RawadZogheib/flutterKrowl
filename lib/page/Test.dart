import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/CustomTab.dart';
import 'package:flutter_app_backend/widgets/CustomTabBar.dart';





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
    ContentView(tab: CustomTab(title: 'Library'), content: Center(
      child: Container(color: Colors.black, width: 90, height: 100,),
    )),
    ContentView(tab: CustomTab(title: 'Chats'), content: Center(
      child: Container(color: Colors.black , width: 90, height: 100,),
    )),
    ContentView(tab: CustomTab(title: 'Forum'), content: Center(
      child: Container(color: Colors.black, width: 90, height: 100,),
    )),
    ContentView(tab: CustomTab(title: 'Students'), content: Center(
      child: Container(color: Colors.black, width: 90, height: 100,),
    )),
    ContentView(tab: CustomTab(title: 'Reminders'), content: Center(
      child: Container(color: Colors.black, width: 90, height: 100,),
    )),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [

              CustomTabBar(
                controller: tabController,
                tabs: contentViews.map((e) => e.tab).toList(),
              ),
            ],
          ),
          Container(
            height: 400,
            child: TabBarView(
              controller: tabController,
                children: contentViews.map((e) => e.content).toList()),
          ),
        ],
      ),
    );
  }
}
