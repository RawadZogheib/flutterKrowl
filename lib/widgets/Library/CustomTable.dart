import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Library/Chairs.dart';
import 'package:flutter_app_backend/widgets/Library/Chairs2.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTable extends StatefulWidget {
  var children;
  var table_name;
  var table_type;
  var height;
  var width;
  var color;
  var icon;
  var seats;
  var id;
  var nb = 0;
  bool hiddenBool = true;
  bool quitSilent = false;
  List<bool> enablee = [false, false, false, false, false, false, false, false];
  List<dynamic> getIds; // Users ids
  List<dynamic> getUsers; // Users names
  List<dynamic> getPos; // Users imgs
  List<dynamic> getImgs; // Users imgs
  List<dynamic> imgs = ['', '', '', '', '', '', '', ''];

  CustomTable(
      {this.children,
      required this.table_name,
      required this.table_type,
      required this.color,
      required this.getIds,
      required this.getUsers,
      required this.getPos,
      required this.getImgs,
      this.id,
      this.icon,
      this.height,
      this.width,
      this.seats});

  @override
  State<CustomTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomTable>
    with TickerProviderStateMixin {
  late Timer timer;
  var tableStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOccupants();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(bottom: 5),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 25,
            height: 50,
            width: 250,
            child: Row(
              children: [
                Text(
                  widget.table_name,
                  style: TextStyle(
                      color: globals.blue1,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " - Choose a seat to join",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 90, bottom: 70, right: 70, left: 70),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.only(right: 12, left: 1),
              decoration: BoxDecoration(
                  color: globals.blue2,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  border: Border.all(color: globals.blue1, width: 4)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.table_type + " Table",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontFamily: 'Rubik')),
                    Text(
                      "${widget.nb.toString()}/8",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontFamily: 'Rubik',
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.grey,
                          ),
                        ),
                        Text(".",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Icon(
                            Icons.mic,
                            color: Colors.grey,
                          ),
                        ),
                        Text(".",
                            style: TextStyle(
                              color: widget.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ))
                      ],
                    )
                  ]),
            ),
          ),
          Positioned(
              top: 65,
              left: 105,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 1),
                angle: 0.0,
              )),
          Positioned(
              top: 65,
              left: 180,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 2),
                angle: 0.0,
              )),
          Positioned(
              top: 140,
              left: 259,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 3),
                angle: -270 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 215,
              left: 259,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 4),
                angle: -270 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 291,
              left: 180,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 5),
                angle: -180 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 291,
              left: 105,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 6),
                angle: -180 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 215,
              left: 34,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 7),
                angle: -90 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 140,
              left: 34,
              child: Chair(
                onTap: () => _sitOnChair(widget.table_name, 8),
                angle: -90 * 3.14159265359 / 180,
              )),
          widget.enablee[0] == true
              ? Positioned(
                  top: 66,
                  left: 105,
                  child: Chair2(img: widget.imgs[0].toString()))
              : Container(),
          widget.enablee[1] == true
              ? Positioned(
                  top: 66,
                  left: 180,
                  child: Chair2(img: widget.imgs[1].toString()))
              : Container(),
          widget.enablee[2] == true
              ? Positioned(
                  top: 127,
                  left: 248,
                  child: Chair2(img: widget.imgs[2].toString()))
              : Container(),
          widget.enablee[3] == true
              ? Positioned(
                  top: 202.5,
                  left: 248,
                  child: Chair2(img: widget.imgs[3].toString()))
              : Container(),
          widget.enablee[4] == true
              ? Positioned(
                  top: 266,
                  left: 180,
                  child: Chair2(img: widget.imgs[4].toString()))
              : Container(),
          widget.enablee[5] == true
              ? Positioned(
                  top: 266,
                  left: 105,
                  child: Chair2(img: widget.imgs[5].toString()))
              : Container(),
          widget.enablee[6] == true
              ? Positioned(
                  top: 202.5,
                  left: 45,
                  child: Chair2(img: widget.imgs[6].toString()))
              : Container(),
          widget.enablee[7] == true
              ? Positioned(
                  top: 127,
                  left: 45,
                  child: Chair2(img: widget.imgs[7].toString()))
              : Container(),
          // hiddenFunction(),
          // Positioned(
          //   top: 15,
          //   right: 20,
          //   child: FlutterSwitch(
          //     width: 60,
          //     height: 27,
          //     valueFontSize: 25.0,
          //     toggleSize: 25.0,
          //     value: widget.status,
          //     borderRadius: 30.0,
          //     padding: 0.0,
          //     activeColor: globals.blue1,
          //     inactiveColor: globals.blue2,
          //     activeToggleColor: globals.blue1,
          //     inactiveToggleColor: globals.blue2,
          //     activeIcon: Icon(
          //       Icons.lightbulb,
          //       color: Colors.yellow,
          //     ),
          //     inactiveIcon: Icon(
          //       Icons.lightbulb_outline_sharp,
          //       color: Colors.white,
          //     ),
          //     onToggle: (val) {
          //       toggleButton(val);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _sitOnChair(String table_name, int position) async {
    if (globals.loadJoinTableLibrary == false) {
      globals.loadJoinTableLibrary = true;
      while (globals.loadLibrary == true ||
          globals.loadCreateTableLibrary == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload createReplyPage");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load joinTable');

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var account_Id = localStorage.getString("account_Id");
        var username = localStorage.getString("username");

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'table_name': table_name,
          'position': position
        };

        var res = await CallApi().postData(data, '(Control)sitOnChair.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              widget.nb++;
              widget.imgs[position - 1] =
              'https://picsum.photos/50/50/?${position -
                  1}'; //get img from server body[1]
              widget.enablee[position - 1] = true;
            });
          }
          if (!await launch(
            globals.jaasUrl + table_name + '&account=' + username.toString() +
                '&type=silent',
            forceSafariVC: false,
            forceWebView: true,
            headers: <String, String>{'my_header_key': 'my_header_value'},
          )) {
            throw 'Could not launch ${globals.jaasUrl + table_name + '&user=' +
                username.toString()}';
          }
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else if (body[0] == "error8") {
          WarningPopup(context, globals.warning8);
        } else if (body[0] == "error9") {
          if (mounted) {
            setState(() {
              widget.imgs[position - 1] =
              'https://picsum.photos/50/50/?${position -
                  1}'; //get img from server body[1]
              widget.enablee[position - 1] = true;
            });
          }
          ErrorPopup(context, globals.error9);
        } else {
          globals.loadJoinTableLibrary = false;
          ErrorPopup(context, globals.errorElse);
        }
      } catch (e) {
        print(e);
        globals.loadJoinTableLibrary = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      globals.loadJoinTableLibrary = false;
      print('load joinTable end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');

    }
  }

  // hiddenFunction() {
  //   if (widget.hiddenBool == true) {
  //     return Container(
  //       height: 360,
  //       width: 340,
  //       color: Colors.black.withOpacity(0.3),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  // toggleButton(bool val) {
  //   // bool test = false;
  //   //
  //   // for (int i = 0; i < globals.occupenTable.length; i++) {
  //   //   // Check all table
  //   //   if (globals.occupenTable[i] == '1') {
  //   //     // Table getting token
  //   //     test = true; // There is table getting token
  //   //     break;
  //   //   }
  //   // }
  //   //if (test == false) {
  //   // There is no  table getting token
  //   if (widget.status == false) {
  //     setState(() {
  //       widget.status = !widget.status;
  //     });
  //
  //     //globals.occupenTable[widget.id] = '1'; // Table getting token
  //     print("stts: 1");
  //     // Toggle  On
  //     widget.hiddenBool = false;
  //     _loadOccupants();
  //     _startTimer();
  //   } else {
  //     // Toggle Off
  //     setState(() {
  //       widget.status = !widget.status;
  //     });
  //     if (timer.isActive) {
  //       timer.cancel();
  //     }
  //     //globals.occupenTable[widget.id] = '0';
  //     setState(() {
  //       //widget.status = false;
  //       globals.tmpid = null;
  //       widget.hiddenBool = true;
  //       widget.imgs = ['','','','','','','',''];
  //       widget.enablee = [
  //         false,
  //         false,
  //         false,
  //         false,
  //         false,
  //         false,
  //         false,
  //         false
  //       ];
  //       widget.nb = '0';
  //     });
  //   }
  //   // } else {
  //   //   // There is table getting token
  //   // }
  // }

  _loadOccupants() async {
    widget.imgs = ['', '', '', '', '', '', '', ''];
    try {
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // String account_Id = localStorage.getString('account_Id').toString();
      // print('fdsfdsfsdf id: ' + account_Id);
      //deload all
      for (int i = 7; i >= 0; i--) {
        if (widget.enablee[i] == false) continue;
        await Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              widget.nb--;
              widget.enablee[i] = false;
            });
          }
        });
      }

      //load all
      for (int i = 0; i < 8; i++) {
        await Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              widget.nb++;
              widget.imgs[i] = '';
              widget.enablee[i] = true;
            });
          }
        });
      }

      if (!widget.getUsers.isEmpty) {
        tableStatus = "success";
      } else {
        tableStatus = "empty";
      }

      if (tableStatus == "success") {
        if (mounted) {
          setState(() {
            widget.nb = widget.getUsers.length;
          });
        }

        //deload

        //int j = widget.getUsers.length - 1;
        for (int i = 7; i >= 0; i--) {
          await Future.delayed(const Duration(milliseconds: 100), () {
            if (int.parse(widget.getPos[i]) != -1) {
              if (mounted) {
                setState(() {
                  widget.imgs[int.parse(widget.getPos[i]) - 1] =
                      widget.getImgs[int.parse(widget.getPos[i]) - 1];
                });
              }
              // if (j > 0) {
              //   j--;
              // }
            } else {
              if (mounted) {
                setState(() {
                  widget.nb--;
                  widget.enablee[i] = false;
                });
              }
            }
          });
        }
      } else if (tableStatus == "empty") {
        if (mounted) {
          setState(() {
            widget.nb = 0;
          });
        }

        //deload
        //int j = body[1].length - 1;
        for (int i = 7; i >= 0; i--) {
          // print('i: ' + i.toString());
          // print('j: ' + j.toString());
          // print('nb: ' + body[2].length.toString());
          await Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() {
                widget.nb--;
                widget.enablee[i] = false;
              });
            }
          });
        }
      } else {
        ErrorPopup(context, globals.errorElse);
      }
    } catch (e) {
      print("Exeption: " + e.toString());
      ErrorPopup(context, globals.errorException);
    }
  }

  // loadOccupants() async {
  //   widget.imgs = ['','','','','','','',''];
  //   try {
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     String account_Id = localStorage.getString('account_Id').toString();
  //     print('fdsfdsfsdf id: ' + account_Id);
  //     //deload all
  //     for (int i = 7; i >= 0; i--) {
  //       if (widget.enablee[i] == false) continue;
  //       await Future.delayed(const Duration(milliseconds: 100), () {
  //         setState(() {
  //           widget.enablee[i] = false;
  //         });
  //       });
  //     }
  //
  //     //load all
  //     for (int i = 0; i < 8; i++) {
  //       await Future.delayed(const Duration(milliseconds: 100), () {
  //         setState(() {
  //           widget.imgs[i] = '';
  //           widget.enablee[i] = true;
  //         });
  //       });
  //     }
  //
  //     var data = {
  //       'version': globals.version,
  //       'account_Id': account_Id,
  //       'table_name': widget.table_name,
  //     };
  //
  //     var res = await CallApi().postData(data, '(Control)loadOccupants.php');
  //     print(res.body);
  //     List<dynamic> body = json.decode(res.body);
  //
  //     if (body[0] == "success") {
  //       // for (int i = 0; i < widget.imgs.length; i++) {
  //       //   widget.imgs[i] = 'https://i.picsum.photos/id/572/500/500?$i';
  //       // }
  //       setState(() {
  //         widget.nb = body[1].length.toString();
  //       });
  //
  //       //deload
  //       int j = body[1].length - 1;
  //       for (int i = 7; i >= 0; i--) {
  //         // print('i: ' + i.toString());
  //         // print('j: ' + j.toString());
  //         // print('nb: ' + body[2].length.toString());
  //         await Future.delayed(const Duration(milliseconds: 100), () {
  //           if (i == (int.parse(body[1][j][2]) - 1)) {
  //             setState(() {
  //               widget.imgs[int.parse(body[1][j][2]) - 1] =
  //                   'https://picsum.photos/50/50/?${Random().nextInt(1000)}';
  //             });
  //             if (j > 0) {
  //               j--;
  //             }
  //           } else {
  //             setState(() {
  //               widget.enablee[i] = false;
  //             });
  //           }
  //         });
  //       }
  //     } else if (body[0] == "empty") {
  //       setState(() {
  //         widget.nb = '0';
  //       });
  //
  //       //deload
  //       //int j = body[1].length - 1;
  //       for (int i = 7; i >= 0; i--) {
  //         // print('i: ' + i.toString());
  //         // print('j: ' + j.toString());
  //         // print('nb: ' + body[2].length.toString());
  //         await Future.delayed(const Duration(milliseconds: 100), () {
  //           setState(() {
  //             widget.enablee[i] = false;
  //           });
  //         });
  //       }
  //       // showDialog<String>(
  //       //   context: context,
  //       //   builder: (BuildContext context) => AlertDialog(
  //       //     title: const Text('Error'),
  //       //     content: const Text(globals.errorEmptyTable),
  //       //     actions: <Widget>[
  //       //       TextButton(
  //       //         onPressed: () => Navigator.pop(context, 'OK'),
  //       //         child: const Text('OK'),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // );
  //     } else if (body[0] == "errorVersion") {
  //       showDialog<String>(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text("Your version: " +
  //               globals.version +
  //               "\n" +
  //               globals.errorVersion),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'OK'),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //     } else if (body[0] == "errorToken") {
  //       showDialog<String>(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text(globals.errorToken),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'OK'),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //     } else if (body[0] == "error4") {
  //       showDialog<String>(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text(globals.error7),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'OK'),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //     } else {
  //       showDialog<String>(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text(globals.errorElse),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'OK'),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print("Exeption: " + e.toString());
  //   }
  //   //globals.occupenTable[widget.id] = '0'; // Table is On
  // }

  // _startTimer() async {
  //   // if(timer.isActive) {
  //   //   timer.cancel();
  //   // }
  //   timer = await Timer(const Duration(seconds: 30), () {
  //     print('Time Out!!!!!!!!!!!!!');
  //     //print('time!!!!!!!!!!!!!: ' + (i).toString());
  //     //globals.occupenTable[widget.id] = '0';
  //     if (mounted) {
  //       setState(() {
  //         widget.status = false;
  //         //globals.tmpid = null;
  //         widget.hiddenBool = true;
  //         widget.imgs = ['', '', '', '', '', '', '', ''];
  //         widget.enablee = [
  //           false,
  //           false,
  //           false,
  //           false,
  //           false,
  //           false,
  //           false,
  //           false
  //         ];
  //         widget.nb = 0;
  //       });
  //     }
  //   });
  // }
}
