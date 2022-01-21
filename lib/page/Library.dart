import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Library/CreateTable.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';
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
    globals.currentPage = 'Library';
    _loadNewPage();
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: globals.white,
        body: Responsive(
          mobile: SingleChildScrollView(
            reverse: false,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CreateTable(
                    onTap: () {
                      _createTable();
                    },
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
                                      image:
                                          AssetImage('Assets/krowl_logo.gif'),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    ),
                                  )
                                : Column(
                                    children: children.reversed.toList(),
                                  )
                          ],
                        ),
                        SizedBox(width: 20),
                      ]),
                ],
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            reverse: false,
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
                                          children: children.reversed.toList(),
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
            reverse: false,
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabBar(),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              load == true
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      CreateTable(
                        onTap: () {
                          _createTable();
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Center(
                            child: Image(
                              image: AssetImage('Assets/krowl_logo.gif'),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          )),
                      SizedBox(width: 20),
                    ])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          CreateTable(
                            onTap: () {
                              _createTable();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.57,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(children: children.reversed.toList()),
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
                        ]),
            ]),
          ),
        ));
  }

  _loadTables() async {
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
      setState(() {
        _totalPages = (body[1] / 12).round() + 1;
      });
      for (var i = 0; i < body[2].length; i++) {
        List<dynamic> _userId = [];
        List<dynamic> _userName = [];
        List<dynamic> _userPosition = [];
        List<dynamic> _userImgUrl = [];

        for (int j = 0; j < body[2][i][3].length; j++) {
          _userId.add(body[2][i][3][j][0]); // userId
          _userName.add(body[2][i][3][j][1]); // userName
          _userPosition.add(body[2][i][3][j][2]); // userPosition
          _userImgUrl.add(
              'https://picsum.photos/50/50/?${Random().nextInt(1000)}' // body[2][i][3][j][3]
              ); // userImgUrl
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
      }

      if (mounted) {
        setState(() {
          children;
        });
      }
    } else if (body[0] == "empty") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorEmptyLibrary),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
    }
  }

  _loadNewPage() {
    timer?.cancel();
    _loadTables(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadTables();
      }
    });
  }

  _createTable() {
    setState(() {
      children.removeLast();
      children.add(CustomTable(
        table_name: globals.tableName,
        getIds: [],
        getUsers: [],
        getPos: [],
        getImgs: [],
        table_type: globals.selectedPublicPrivet,
        color: Colors.green,
      ));
      //globals.occupenTable.add('0');
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
