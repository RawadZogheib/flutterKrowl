import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Responsive.dart';
import 'package:Krowl/widgets/Library/CreateTable.dart';
import 'package:Krowl/widgets/Library/CustomTable.dart';
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:Krowl/widgets/MyDrawer.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:number_paginator/number_paginator.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Library()));

class Library extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Library> createState() => _TestState();
}

class _TestState extends State<Library> with SingleTickerProviderStateMixin {
  bool _isPrivet = false;
  bool _isPrivetLoad = true;
  List<CustomTable> _children = <CustomTable>[];
  Timer? timer;
  int _currentPage = 1;
  int _totalPages = 0;
  int _totalTables = 0;
  int _maxTables = 12;
  bool load = true;

  int _key = 0;

  Timer? timer2;
  AnimationController? animationController;
  final int _animationDuration = 4;
  int _k = 0;

  @override
  void initState() {
    _distAnimation();
    _onInitState();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    timer2?.cancel();
    animationController?.stop();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    Animation distAnimation = Tween(begin: 4.0, end: 20.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn));
    if (_k % 2 == 0) {
      animationController!.forward();
    } else {
      animationController!.reverse();
    }

    return WillPopScope(
      onWillPop: () async => _back(),
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget) => Scaffold(
          resizeToAvoidBottomInset: true,
          drawer: MyDrawer(),
          appBar: MediaQuery.of(context).size.width < 700
              ? AppBar(
                  backgroundColor: globals.blue1,
                  title: Center(
                    child: Text('Krowl'),
                  ),
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _back();
                      }),
                  actions: [
                    Builder(
                      builder: (context) => IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ],
                )
              : null,
          backgroundColor: globals.white,
          body: Responsive(
            mobile: Stack(
              children: [
                ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: SingleChildScrollView(
                    reverse: false,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                            height: 435,
                            width: 270,
                            child: CreateTable(
                              height: double.parse(
                                  (415 + distAnimation.value).toString()),
                              width: double.parse(
                                  (250 + distAnimation.value).toString()),
                              onTap: (thisId, thisTableCode) =>
                                  _createTable(thisId, thisTableCode),
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
                                Expanded(
                                  child: Column(
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
                                            children: [
                                              Column(
                                                  children:
                                                      _children.toList()),
                                              _totalPages != 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: NumberPaginator(
                                                        numberPages:
                                                            _totalPages,
                                                        onPageChange:
                                                            (int index) {
                                                          if (mounted) {
                                                            setState(() {
                                                              _currentPage =
                                                                  index + 1;
                                                              _loadNewPage();
                                                              print(
                                                                  index + 1);
                                                            });
                                                          }
                                                        },
                                                        // initially selected index
                                                        initialPage:
                                                            _currentPage - 1,
                                                        // default height is 48
                                                        buttonShape:
                                                            BeveledRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8),
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
                                                    )
                                                  : Container(
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.75,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                              'Assets/krowl_logo.gif',
                                                            ),
                                                            fit: BoxFit.cover,
                                                            height: 250,
                                                            width: 250,
                                                          ),
                                                          Text(
                                                            globals
                                                                .warningEmptyLibrary,
                                                            style: TextStyle(
                                                                fontSize: 32),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () async {
                      if (_isPrivetLoad == false) {
                        _isPrivetLoad = true;
                        if (mounted) {
                          setState(() {
                            _isPrivet = !_isPrivet;
                          });
                        }
                        await _loadNewPage();
                        if (_isPrivet == true) {
                          print('Private Mode');
                        } else {
                          print('Public Mode');
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: globals.blue1,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          bottomRight: Radius.circular(22.0),
                        ),
                      ),
                      child: _isPrivet == true
                          ? SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.private_connectivity,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Private',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Public',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
                    children: [
                      SizedBox(
                        height: 165,
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Builder(builder: (context) {
                                return ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
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
                                            onTap: (thisId, thisTableCode) =>
                                                _createTable(
                                                    thisId, thisTableCode),
                                          ),
                                        ),
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  load == true
                                      ? Expanded(
                                          child: SizedBox(
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
                                        )
                                      : Expanded(
                                          child: ScrollConfiguration(
                                            behavior: MyCustomScrollBehavior(),
                                            child: SingleChildScrollView(
                                              controller: ScrollController(),
                                              reverse: false,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Wrap(
                                                        children:
                                                            _children.toList()),
                                                    _totalPages != 0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                NumberPaginator(
                                                              numberPages:
                                                                  _totalPages,
                                                              onPageChange:
                                                                  (int index) {
                                                                if (mounted) {
                                                                  setState(() {
                                                                    _currentPage =
                                                                        index +
                                                                            1;
                                                                    _loadNewPage();
                                                                    print(
                                                                        index +
                                                                            1);
                                                                  });
                                                                }
                                                              },
                                                              // initially selected index
                                                              initialPage:
                                                                  _currentPage -
                                                                      1,
                                                              // default height is 48
                                                              buttonShape:
                                                                  BeveledRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
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
                                                          )
                                                        : Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.75,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image(
                                                                  image:
                                                                      AssetImage(
                                                                    'Assets/krowl_logo.gif',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 250,
                                                                  width: 250,
                                                                ),
                                                                Text(
                                                                  globals
                                                                      .warningEmptyLibrary,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          32),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ],
                                                ),
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
                Positioned(
                  top: 113.5,
                  right: 10,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () async {
                      if (_isPrivetLoad == false) {
                        _isPrivetLoad = true;
                        if (mounted) {
                          setState(() {
                            _isPrivet = !_isPrivet;
                          });
                        }
                        await _loadNewPage();
                        if (_isPrivet == true) {
                          print('Private Mode');
                        } else {
                          print('Public Mode');
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: globals.blue1,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          bottomRight: Radius.circular(22.0),
                        ),
                      ),
                      child: _isPrivet == true
                          ? SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.private_connectivity,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Private',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Public',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                CustomTabBar(
                  color: globals.blue1,
                ),
              ],
            ),
            desktop: Stack(
              children: [
                Column(children: [
                  SizedBox(
                    height: 165,
                  ),
                  load == true
                      ? Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
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
                                            onTap: (thisId, thisTableCode) =>
                                                _createTable(
                                                    thisId, thisTableCode),
                                          ),
                                        ),
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.68,
                                    alignment: Alignment.topCenter,
                                    margin: EdgeInsets.only(top: 10),
                                    child: Image(
                                      image: AssetImage(
                                        'Assets/krowl_logo.gif',
                                      ),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                              ]),
                        )
                      : Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
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
                                            onTap: (thisId, thisTableCode) =>
                                                _createTable(
                                                    thisId, thisTableCode),
                                          ),
                                        ),
                                        SizedBox(
                                          height: distAnimation.value,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: SingleChildScrollView(
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
                                          Wrap(children: _children.toList()),
                                          _totalPages != 0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: NumberPaginator(
                                                    numberPages: _totalPages,
                                                    onPageChange: (int index) {
                                                      if (mounted) {
                                                        setState(() {
                                                          _currentPage =
                                                              index + 1;
                                                          _loadNewPage();
                                                          print(index + 1);
                                                        });
                                                      }
                                                    },
                                                    // initially selected index
                                                    initialPage:
                                                        _currentPage - 1,
                                                    // default height is 48
                                                    buttonShape:
                                                        BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                                )
                                              : Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                          'Assets/krowl_logo.gif',
                                                        ),
                                                        fit: BoxFit.cover,
                                                        height: 250,
                                                        width: 250,
                                                      ),
                                                      Text(
                                                        globals
                                                            .warningEmptyLibrary,
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                ]),
                Positioned(
                  top: 113.5,
                  right: 10,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () async {
                      if (_isPrivetLoad == false) {
                        _isPrivetLoad = true;
                        if (mounted) {
                          setState(() {
                            _isPrivet = !_isPrivet;
                          });
                        }
                        await _loadNewPage();
                        if (_isPrivet == true) {
                          print('Private Mode');
                        } else {
                          print('Public Mode');
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: globals.blue1,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          bottomRight: Radius.circular(22.0),
                        ),
                      ),
                      child: _isPrivet == true
                          ? SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.private_connectivity,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Private',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 90,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Public',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                CustomTabBar(
                  color: globals.blue1,
                ),
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
        // if (mounted) {
        //   setState(() {
        //     _children.clear();
        //     load = true;
        //   });
        // }
        ///////////////////////

        //globals.occupenTable.clear();
        var account_Id = await SessionManager().get('account_Id');
        var user_uni = await SessionManager().get('user_uni');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'currentPage': _currentPage,
          'user_uni': user_uni,
          'isPrivet': _isPrivet == true ? '2' : '1',
        };

        var res = await CallApi().postData(data, '(Control)loadTables.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (mounted) {
          setState(() {
            load = false;
          });
        }

        _children.clear();
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
            List<dynamic> _userJitBool = ['', '', '', '', '', '', '', ''];
            //privet
            List<dynamic> _userIdPrivet = [];
            List<dynamic> _userNamePrivet = [];
            List<dynamic> _userImgUrlPrivet = [];
            if (_isPrivet == true) {
              for (int j = 0; j < body[2][i][8].length; j++) {
                _userIdPrivet.add(body[2][i][8][j][0]); // userId
                _userNamePrivet.add(body[2][i][8][j][1]); // userName
                _userImgUrlPrivet.add(
                    'https://picsum.photos/50/50/?${Random().nextInt(1000)}'); // body[2][i][4][j][2]
                // userImgUrl
              }
              for (int j = 0; j < body[2][i][9].length; j++) {
                _userId[int.parse(body[2][i][9][j][2]) - 1] =
                    body[2][i][9][j][0]; // userId
                _userName[int.parse(body[2][i][9][j][2]) - 1] =
                    body[2][i][9][j][1]; // userName
                _userPosition[int.parse(body[2][i][9][j][2]) - 1] =
                    body[2][i][9][j][2]; // userPosition
                _userImgUrl[int.parse(body[2][i][9][j][2]) - 1] =
                    'https://picsum.photos/50/50/?${Random().nextInt(1000)}'; // body[2][i][5][j][3]
                // userImgUrl
              }
            } else {
              for (int j = 0; j < body[2][i][8].length; j++) {
                _userId[int.parse(body[2][i][8][j][2]) - 1] =
                    body[2][i][8][j][0]; // userId
                _userName[int.parse(body[2][i][8][j][2]) - 1] =
                    body[2][i][8][j][1]; // userName
                _userPosition[int.parse(body[2][i][8][j][2]) - 1] =
                    body[2][i][8][j][2]; // userPosition
                _userImgUrl[int.parse(body[2][i][8][j][2]) - 1] =
                    'https://picsum.photos/50/50/?${Random().nextInt(1000)}'; // body[2][i][4][j][3]
                // userImgUrl
              }
            }
            // localStorage.setString('contrat_Id', value)
            // globals.occupenTable.add('0');// Initiate table (All table are Off)

            // print('_key: ' + _key.toString());
            _children.add(
              new CustomTable(
                account_Id: account_Id,
                key: ValueKey(_key++),
                id: body[2][i][0].toString(),
                tableCode: body[2][i][1],
                table_name: body[2][i][2],
                seats: body[2][i][3],
                isSilent: body[2][i][4],
                isPrivet: _isPrivet,
                color: Colors.green,
                getIds: _userId,
                getUsers: _userName,
                getPos: _userPosition,
                getImgs: _userImgUrl,
                getIdsPrivet: _userIdPrivet,
                getUsersPrivet: _userNamePrivet,
                getImgsPrivet: _userImgUrlPrivet,
                isNew: body[2][i][5],
                isControlPanel: body[2][i][6],
                isAdmin: body[2][i][7],
                onRemoveTable: (tableId) => _onRemoveTable(tableId),
              ),
            );
            // print(_userId);
            // print(_userName);
            // print(_userPosition);
            // print(_userImgUrl);
          }

          if (mounted) {
            setState(() {
              _children;
            });
          }
        } else if (body[0] == "empty") {
          if (_currentPage != 1) {
            setState(() {
              _currentPage = 1;
              _loadNewPage();
            });
          } else {
            setState(() {
              _totalTables = 0;
              _totalPages = 0;
            });
            //WarningPopup(context, globals.warningEmptyLibrary);
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
    _isPrivetLoad = false;
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

  _createTable(String id, String tableCode) async {
    var account_Id = await SessionManager().get('account_Id');
    if (mounted) {
      setState(() {
        if (globals.isPrivet == _isPrivet) {
          _totalTables++;
          _totalPages = (_totalTables / _maxTables).ceil();
          if (_currentPage != 1) {
            _currentPage = 1;
            _loadNewPage();
          } else {
            if (_children.length == _maxTables) _children.removeLast();
            _children.insert(
                0,
                CustomTable(
                  account_Id: account_Id,
                  id: id,
                  tableCode: tableCode,
                  table_name: globals.tableName,
                  getIds: [],
                  getUsers: [],
                  getPos: [],
                  getImgs: [],
                  isSilent: globals.isSilent,
                  isPrivet: globals.isPrivet,
                  color: Colors.green,
                  getIdsPrivet: ['', '', '', '', '', '', '', ''],
                  getUsersPrivet: ['', '', '', '', '', '', '', ''],
                  getImgsPrivet: ['', '', '', '', '', '', '', ''],
                  isNew: true,
                  isControlPanel: false,
                  isAdmin: true,
                  onRemoveTable: (tableId) => _onRemoveTable(tableId),
                ));
          } 

          //globals.occupenTable.add('0');
        }
      });
    }
  }

  void _distAnimation() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: _animationDuration));
    timer2 =
        Timer.periodic(Duration(seconds: _animationDuration), (Timer t) async {
      if (mounted) {
        setState(() {
          _k++;
          print('$_animationDuration Second');
        });
      }
    });
  }

  Future<void> _onInitState() async {
    if (await SessionManager().get('isLoggedIn') == true) {
      globals.currentPage = 'Library';
      _loadNewPage();
      if (await SessionManager().containsKey("arg")) {
        setState(() {
          _isPrivet = true;
        });
        await SessionManager().remove('arg');
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/intro_page', (route) => false);
    }
  }

  _onRemoveTable(String tableId) {
    _children
        .removeAt(_children.indexWhere((element) => (element.id == tableId)));
    if (mounted) {
      setState(() {
        _children;
      });
    }
  }

  _back() async {
    //Navigator.pop(context);
    await SessionManager().set('isLoggedIn', false);
    Navigator.pushNamedAndRemoveUntil(context, '/intro_page', (route) => false);
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
