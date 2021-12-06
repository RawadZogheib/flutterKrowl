import 'dart:convert';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Library/CreateRoom.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final children1 = <Widget>[];
final children2 = <Widget>[];

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
    _loadTables();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
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
                    CustomTable(roomName: "room name",
                        roomType: "room",
                        color: Colors.green)
                  ]),
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
                  CreateRoom(),
                  SizedBox(height: 20,),
                  Column(children: [
                    CustomTable(roomName: "room name",
                        roomType: "room",
                        color: Colors.green)
                  ]),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CreateRoom(),
                          SizedBox(width: 20,),
                          Wrap(
                            children: [
                              Column(
                                children: children1,
                              ),
                              Column(
                                children: children2,
                              )
                            ],
                          ),
                          SizedBox(width: 20),
                        ]),),

                ],
              ),
            ]),
          ),
        ));
  }

  Future<void> _loadTables() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");

    var data = {
      'version': globals.version,
      'user_id': user_id
    };

    var res = await CallApi().postData(
        data, '(Control)loadTables.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        //localStorage.setString('contrat_Id', value)
        if (i % 2 == 0) {
          children1.add(
            CustomTable(roomName: body[1][i][0],
                roomType: "Quiet",
                color: Colors.green,
                seats: body[1][i][1]),
          );
        } else {
          children2.add(
            CustomTable(roomName: body[1][i][0],
                roomType: "Quiet",
                color: Colors.green,
                seats: body[1][i][1]),
          );
        }
      }
      setState(() {
        children1;
        children2;
      });
    }
    else {
      print("errroorrrrrr");
    }
  }
}
