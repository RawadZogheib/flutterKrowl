import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/hexColor/hexColor.dart';
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';
import 'package:flutter_app_backend/widgets/MyDrawer.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Library()));

class Library extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Library> createState() => _TestState();
}

class _TestState extends State<Library> with SingleTickerProviderStateMixin {
  List<CustomTable> children = <CustomTable>[];
  Timer? timer;
  int _currentPage = 1;
  int _totalPages = 999;
  int _totalTables = 11988;
  int _maxTables = 12;
  bool load = true;

  Timer? timer2;
  AnimationController? animationController;
  final int _animationDuration = 4;
  int _k = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer2?.cancel();
    animationController?.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    globals.currentPage = 'Library';
    _distAnimation();
    _loadNewPage();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    Animation distAnimation = Tween(begin: 4.0, end: 20.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn));
    if (_k % 2 == 0) {
      animationController!.forward();
    } else {
      animationController!.reverse();
    }

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget) => Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: MyDrawer(),
        appBar: MediaQuery.of(context).size.width < 700?AppBar(
          backgroundColor: globals.blue1,
          title: Center(child: Text('Krowl')),
        ):null,
        backgroundColor: globals.white,
        body: Builder(
          builder: (context) => Responsive(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: false,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 435,
                            width: 270,
                            child: CreateTable(
                              height: double.parse(
                                  (415 + distAnimation.value).toString()),
                              width: double.parse(
                                  (250 + distAnimation.value).toString()),
                              onTap: () {
                                _createTable();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Wrap(
                                  children: [
                                    load == true
                                        ? Center(
                                            child: Image(
                                              image: AssetImage(
                                                  'Assets/krowl_logo.gif'),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                          )
                                        : Column(
                                            children: children.toList(),
                                          )
                                  ],
                                ),
                                SizedBox(width: 20),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            tablet: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: distAnimation.value,
                                    ),
                                    SizedBox(
                                      height: 435,
                                      width: 270,
                                      child: CreateTable(
                                        height: double.parse(
                                            (415 + distAnimation.value)
                                                .toString()),
                                        width: double.parse(
                                            (250 + distAnimation.value)
                                                .toString()),
                                        onTap: () {
                                          _createTable();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: distAnimation.value,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  load == true
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Center(
                                                  child: Image(
                                                    image: AssetImage(
                                                        'Assets/krowl_logo.gif'),
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                )),
                                          ],
                                        )
                                      : Expanded(
                                          child: SingleChildScrollView(
                                            controller: ScrollController(),
                                            reverse: false,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Wrap(
                                                children: children.toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(width: 20),
                            ]),
                      ),
                    ],
                  ),
                ),
                CustomTabBar(),
              ],
            ),
            desktop: Stack(
              children: [
                Column(children: [
                  SizedBox(
                    height: 130,
                  ),
                  load == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: distAnimation.value,
                                    ),
                                    SizedBox(
                                      height: 435,
                                      width: 270,
                                      child: CreateTable(
                                        height: double.parse(
                                            (415 + distAnimation.value)
                                                .toString()),
                                        width: double.parse(
                                            (250 + distAnimation.value)
                                                .toString()),
                                        onTap: () {
                                          _createTable();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: distAnimation.value,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.68,
                                  child: Center(
                                    child: Image(
                                      image:
                                          AssetImage('Assets/krowl_logo.gif'),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                            ])
                      : Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: distAnimation.value,
                                      ),
                                      SizedBox(
                                        height: 435,
                                        width: 270,
                                        child: CreateTable(
                                          height: double.parse(
                                              (415 + distAnimation.value)
                                                  .toString()),
                                          width: double.parse(
                                              (250 + distAnimation.value)
                                                  .toString()),
                                          onTap: () {
                                            _createTable();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: distAnimation.value,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SingleChildScrollView(
                                  controller: ScrollController(),
                                  reverse: false,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.68,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              buttonShape:
                                                  BeveledRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                ),
                              ]),
                        ),
                ]),
                CustomTabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadTables() async {
    if (globals.loadLibrary == false) {
      globals.loadLibrary = true;
      while (globals.loadJoinTableLibrary == true ||
          globals.loadCreateTableLibrary == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload library");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      try {
        print('load library');

        ///// To be removed ////
        if (mounted) {
          setState(() {
            children.clear();
            load = true;
          });
        }
        ///////////////////////

        //globals.occupenTable.clear();
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var account_Id = localStorage.getString("account_Id");
        var user_uni = localStorage.getString("user_uni");

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'currentPage': _currentPage,
          'user_uni': user_uni,
        };

        var res = await CallApi().postData(data, '(Control)loadTables.php');
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
              _totalTables = int.parse(body[1]);
              _totalPages = (_totalTables / _maxTables).ceil();
            });
          }
          for (var i = 0; i < body[2].length; i++) {
            List<dynamic> _userId = ['', '', '', '', '', '', '', ''];
            List<dynamic> _userName = ['', '', '', '', '', '', '', ''];
            List<dynamic> _userPosition = [
              '-1',
              '-1',
              '-1',
              '-1',
              '-1',
              '-1',
              '-1',
              '-1'
            ];
            List<dynamic> _userImgUrl = ['', '', '', '', '', '', '', ''];

            for (int j = 0; j < body[2][i][3].length; j++) {
              _userId[int.parse(body[2][i][3][j][2]) - 1] =
                  body[2][i][3][j][0]; // userId
              _userName[int.parse(body[2][i][3][j][2]) - 1] =
                  body[2][i][3][j][1]; // userName
              _userPosition[int.parse(body[2][i][3][j][2]) - 1] =
                  body[2][i][3][j][2]; // userPosition
              _userImgUrl[int.parse(body[2][i][3][j][2]) - 1] =
                  'https://picsum.photos/50/50/?${Random().nextInt(1000)}'; // body[2][i][3][j][3]
              // userImgUrl
            }
            //localStorage.setString('contrat_Id', value)
            //globals.occupenTable.add('0');// Initiate table (All table are Off)
            children.add(
              new CustomTable(
                id: i,
                table_name: body[2][i][0],
                seats: body[2][i][1],
                table_type: body[2][i][2],
                color: Colors.green,
                getIds: _userId,
                getUsers: _userName,
                getPos: _userPosition,
                getImgs: _userImgUrl,
              ),
            );
            print(_userId);
            print(_userName);
            print(_userPosition);
            print(_userImgUrl);
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
          if (mounted) {
            setState(() {
              load = true;
            });
          }
          globals.loadLibrary = false;
          ErrorPopup(context, globals.errorElse);
        }
      } catch (e) {
        print(e);
        globals.loadLibrary = false;
        if (mounted) {
          setState(() {
            load = true;
            ErrorPopup(context, globals.errorException);
          });
        }
      }
      globals.loadLibrary = false;
      print('load library end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _loadNewPage() {
    print(
        '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadTables(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadTables();
      } else {
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }

  _createTable() {
    if (mounted) {
      setState(() {
        _totalTables++;
        _totalPages = (_totalTables / _maxTables).ceil();
        if (_currentPage != 1) {
          _currentPage = 1;
          _loadNewPage();
        } else {
          if (children.length == _maxTables) children.removeLast();
          children.insert(
              0,
              CustomTable(
                table_name: globals.tableName,
                getIds: [],
                getUsers: [],
                getPos: [],
                getImgs: [],
                table_type: globals.selectedPublicPrivet,
                color: Colors.green,
              ));
        }

        //globals.occupenTable.add('0');
      });
    }
  }

  void _distAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: _animationDuration));
    timer2 =
        Timer.periodic(Duration(seconds: _animationDuration), (Timer t) async {
      setState(() {
        _k++;
        print('$_animationDuration Second');
      });
    });
  }

// _columnChecker(int val, int nb) {
//   if (val == 0) {
//     for (var i = nb; i <= 0; i--) {
//       print(i);
//       if (i % 2 == 0) {
//         _columnChecker(val, i);
//         return CustomTable(
//           id: globals.children[i].id,
//           table_name: globals.children[i].table_name,
//           table_type: globals.children[i].table_type,
//           color: globals.children[i].color,
//           seats: globals.children[i].seats,
//         );
//       } else {
//         _columnChecker(val, i);
//       }
//     }
//   } else if (val == 1) {
//     for (var i = nb; i <= 0; i--) {
//       if (i % 2 != 0) {
//         _columnChecker(val, i);
//         return CustomTable(
//           id: globals.children[i].id,
//           table_name: globals.children[i].table_name,
//           table_type: globals.children[i].table_type,
//           color: globals.children[i].color,
//           seats: globals.children[i].seats,
//         );
//       } else {
//         _columnChecker(val, i);
//       }
//     }
//   } else {
//     print("val =/= 0 and 1");
//     exit;
//   }
// }
}
