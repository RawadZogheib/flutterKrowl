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
  bool load = false;

  @override
  void initState() {
    super.initState();
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
                      setState(() {
                        children.add(CustomTable(
                          table_name: globals.tableName,
                          getUsers: [],
                          getImgs: ['', '', '', '', '', '', '', ''],
                          table_type: globals.selectedPublicPrivet,
                          color: Colors.green,
                        ));
                        //globals.occupenTable.add('0');
                      });
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
                      CreateTable(
                        onTap: () {
                          setState(() {
                            children.add(CustomTable(
                              table_name: globals.tableName,
                              getUsers: [],
                              getImgs: ['', '', '', '', '', '', '', ''],
                              table_type: globals.selectedPublicPrivet,
                              color: Colors.green,
                            ));
                            //globals.occupenTable.add('0');
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: 950,
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
                          CreateTable(
                            onTap: () {
                              setState(() {
                                children.add(CustomTable(
                                  table_name: globals.tableName,
                                  getUsers: [],
                                  getImgs: ['', '', '', '', '', '', '', ''],
                                  table_type: globals.selectedPublicPrivet,
                                  color: Colors.green,
                                ));
                                //globals.occupenTable.add('0');
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.57,
                              child: Column(
                                children: [
                                  Wrap(children: children.reversed.toList()),
                                  NumberPaginator(
                                    numberPages: 35,
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
                                ],
                              )),
                          SizedBox(width: 20),
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
      'user_uni': user_uni,
    };

    var res = await CallApi().postData(data, '(Control)loadTables.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    setState(() {
      load = false;
    });

    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        //localStorage.setString('contrat_Id', value)
        //globals.occupenTable.add('0');// Initiate table (All table are Off)
        children.add(
          new CustomTable(
              id: i,
              table_name: body[1][i][0],
              getUsers: [],
              // Users names on the table
              getImgs: [
                // Imgs of users on the  table
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
                'https://picsum.photos/50/50/?${Random().nextInt(1000)}',
              ],
              table_type: "1",
              color: Colors.green,
              seats: body[1][i][1]),
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
