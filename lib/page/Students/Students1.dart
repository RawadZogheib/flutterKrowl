import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/SearchBar.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/Students/StudentCard.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Students1()));

class Students1 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Students1> createState() => _Students1State();
}

class _Students1State extends State<Students1>
    with SingleTickerProviderStateMixin {
  @override
  var children = <StudentCard>[]; // StudentsCards
  Timer? timer;
  int _currentPage = 1;
  int _totalPages = 999;
  int _totalStudents = 11988;
  bool load = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    globals.currentPage = 'Students';
    _loadNewPage();
  }

  Widget build(BuildContext context) {
    //Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: false,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBar(hintText: "Search for students..."),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: children, // My Children
                ),
              ],
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SearchBar(hintText: "Search for students..."),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: children, // My Children
                    ),
                  ],
                ),
              ],
            ),
          ),
          desktop: Stack(
            children: [
              SingleChildScrollView(
                reverse: false,
                child: Column(children: [
                  SizedBox(
                    height: 130,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SearchBar(hintText: "Search for students..."),
                          SizedBox(
                            height: 30,
                          ),
                          load == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.57,
                                          child: Center(
                                            child: Image(
                                              image: AssetImage(
                                                  'Assets/krowl_logo.gif'),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                          )),
                                      SizedBox(width: 20),
                                    ])
                              : Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Wrap(children: children.toList()),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: NumberPaginator(
                                          numberPages: _totalPages,
                                          onPageChange: (int index) {
                                            setState(() {
                                              _currentPage = index + 1;
                                              _loadNewPage();
                                              print(index + 1);
                                            });
                                          },
                                          // initially selected index
                                          initialPage: _currentPage - 1,
                                          // default height is 48
                                          buttonShape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          buttonSelectedForegroundColor:
                                              globals.blue2,
                                          buttonUnselectedForegroundColor:
                                              globals.blue1,
                                          buttonUnselectedBackgroundColor:
                                              globals.blue2,
                                          buttonSelectedBackgroundColor:
                                              globals.blue1,
                                        ),
                                      ),
                                    ],
                                  )),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              CustomTabBar(),
            ],
          ),
        ));
  }

  _loadStudents() async {
    try {
      children.clear();
      if (mounted) {
        setState(() {
          children.clear();
          load = true;
        });
      }

      //globals.occupenTable.clear();
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var account_Id = localStorage.getString("account_Id");
      var user_uni = localStorage.getString("user_uni");

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'currentPage': _currentPage,
        //'user_uni': user_uni,
      };

      var res = await CallApi().postData(data, '(Control)loadStudents.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (mounted) {
        setState(() {
          load = false;
        });
      }
      if (body[0] == "success") {
        if (mounted) {
          setState(() {
            _totalStudents = int.parse(body[1]);
            _totalPages = (_totalStudents / 20).ceil();
          });
        }
        for (var i = 0; i < body[2].length; i++) {
          children.add(
            StudentCard(
              userId: body[2][i][0],
              username: body[2][i][1] + ' ' + body[2][i][2],
              universityname: body[2][i][4],
              isFriend: body[2][i][5],
              userImg: body[2][i][3],
              contextStudentPage: context,
              reload: () {
                _loadNewPage();
              },
            ),
          );
        }

        if (mounted) {
          setState(() {
            children;
          });
        }
      } else if (body[0] == "empty") {
        if (_currentPage != 1) {
          setState(() {
            _currentPage = 1;
            _loadNewPage();
          });
        } else {
          WarningPopup(context, globals.warningEmptyLibrary);
        }
      } else if (body[0] == "errorVersion") {
        ErrorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        ErrorPopup(context, globals.errorToken);
      } else if (body[0] == "error7") {
        WarningPopup(context, globals.warning7);
      } else {
        ErrorPopup(context, globals.errorElse);
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      ErrorPopup(context, globals.errorException);
    }
  }

  _loadNewPage() {
    timer?.cancel();
    _loadStudents(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadStudents();
      }
    });
  }
}
