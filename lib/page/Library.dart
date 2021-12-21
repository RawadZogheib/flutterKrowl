import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/Data/ContentView.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTab.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                                  Column(
                                    children: globals.children,
                                  )
                                ],
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
                                  Column(
                                    children: globals.children,
                                  )
                                ],
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
                  Image.asset(
                    'Assets/krowl_logo.png',
                    scale: 2.0,
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  CustomTabBar(
                    controller: tabController,
                    tabs: contentViews.map((e) => e.tab).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CreateTable(),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 700,
                              child: Wrap(children: globals.children)),
                          SizedBox(width: 20),
                        ]),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Future<void> _loadTables() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");
    var user_uni = localStorage.getString("user_uni");

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'user_uni': user_uni,
    };

    var res = await CallApi().postData(data, '(Control)loadTables.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
      for (var i = 0; i < body[2].length; i++) {
        //localStorage.setString('contrat_Id', value)
        globals.children.add(
          CustomTable(
              id: i,
              table_name: body[2][i][0],
              table_type: "1",
              color: Colors.green,
              seats: body[2][i][1]),
        );
      }
      setState(() {
        globals.children;
      });
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error7),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error11") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error11),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  _columnChecker(int val, int nb) {
    if (val == 0) {
      for (var i = nb; i <= 0; i--) {
        print(i);
        if (i % 2 == 0) {
          _columnChecker(val, i);
          return CustomTable(
            id: globals.children[i].id,
            table_name: globals.children[i].table_name,
            table_type: globals.children[i].table_type,
            color: globals.children[i].color,
            seats: globals.children[i].seats,
          );
        } else {
          _columnChecker(val, i);
        }
      }
    } else if (val == 1) {
      for (var i = nb; i <= 0; i--) {
        if (i % 2 != 0) {
          _columnChecker(val, i);
          return CustomTable(
            id: globals.children[i].id,
            table_name: globals.children[i].table_name,
            table_type: globals.children[i].table_type,
            color: globals.children[i].color,
            seats: globals.children[i].seats,
          );
        } else {
          _columnChecker(val, i);
        }
      }
    } else {
      print("val =/= 0 and 1");
      exit;
    }
  }
}
