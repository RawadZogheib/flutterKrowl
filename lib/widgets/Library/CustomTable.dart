import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Library/Chairs.dart';
import 'package:Krowl/widgets/Library/Chairs2.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopup.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTable extends StatefulWidget {
  int account_Id;
  var children;
  String tableCode;
  var table_name;

  //var table_type;
  var height;
  var width;
  var color;
  var icon;
  var seats;
  String id;
  var nb = 0;

  // bool hiddenBool = true;
  bool isSilent;
  bool isPrivet;
  bool isNew;
  bool isControlPanel;
  bool isAdmin;
  List<bool> enablee = [false, false, false, false, false, false, false, false];
  List<dynamic> getIds; // Users ids
  List<dynamic> getUsers; // Users names
  List<dynamic> getPos; // Users imgs
  List<dynamic> getImgs; // Users imgs
  List<dynamic> imgs = ['', '', '', '', '', '', '', ''];

  //privet
  List<dynamic> getIdsPrivet = [];
  List<dynamic> getUsersPrivet = [];
  List<dynamic> getImgsPrivet = [];

  var onRemoveTable;

  CustomTable({
    Key? key,
    required this.id,
    required this.account_Id,
    this.children,
    required this.tableCode,
    required this.table_name,
    required this.color,
    required this.getIds,
    required this.getUsers,
    required this.getPos,
    required this.getImgs,
    required this.isSilent,
    required this.isPrivet,
    required this.isNew,
    required this.isControlPanel,
    required this.isAdmin,
    required this.getIdsPrivet,
    required this.getUsersPrivet,
    required this.getImgsPrivet,
    this.icon,
    this.height,
    this.width,
    this.seats,
    required this.onRemoveTable,
  }) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomTable>
    with TickerProviderStateMixin {
  late Webview _webview;
  int _myPos = -9999;
  bool _iconIsClicked = false;
  bool _iconIsClicked2 = false;
  bool _edit = false;
  late Timer timer;
  var tableStatus;
  bool _isInMeeting = false;

  AnimationController? animationController;
  AnimationController? animationController2;

  @override
  void initState() {
    // TODO: implement initState
    _loadOccupants();
    // Timer.periodic(const Duration(seconds: 30), (Timer t) {
    //   if (mounted) {
    //     _loadOccupants();
    //   }
    // });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController!);
    if (_iconIsClicked)
      animationController!.forward();
    else
      animationController!.reverse();

    Animation<double> opacityAnimation2 =
        Tween(begin: 0.0, end: 1.0).animate(animationController2!);
    if (_iconIsClicked2)
      animationController2!.forward();
    else
      animationController2!.reverse();
    return Container(
      width: 349,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isControlPanel == true
              ? Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: globals.blue1,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0.0),
                      topLeft: Radius.circular(22.0),
                      bottomRight: Radius.circular(22.0),
                      bottomLeft: Radius.circular(0.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //join video call (jit)
                      InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => _startJit(widget.table_name, _myPos),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.play_arrow_outlined,
                            color: globals.white,
                          ),
                        ),
                      ),
                      //leave meeting
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          color: globals.blue1,
                        ),
                      ),

                      _isInMeeting == true
                          ? InkWell(
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => _leftOccupant(),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.logout,
                                  color: globals.white,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.logout,
                                color: globals.blue1,
                              ),
                            ),

                      InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => _closeControlPanel(),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            color: globals.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Container(
            width: 350,
            margin: EdgeInsets.only(bottom: 5),
            child: Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 90, bottom: 70, right: 80, left: 70),
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
                          Text(
                              widget.isSilent == false
                                  ? 'Quiet Table'
                                  : 'Silent Table',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Rubik')),
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

                //Check Members
                widget.isAdmin == true && widget.isPrivet == true
                    ? IgnorePointer(
                        ignoring: !_iconIsClicked,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Row(
                                  children: [
                                    Expanded(child: SizedBox()),
                                    FadeTransition(
                                      opacity: opacityAnimation,
                                      child: ShapedWidget2(
                                        getIdsPrivet: widget.getIdsPrivet,
                                        getUsersPrivet: widget.getUsersPrivet,
                                        getImgsPrivet: widget.getImgsPrivet,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                //Add Members
                widget.isPrivet == true
                    ? IgnorePointer(
                        ignoring: !_iconIsClicked2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Row(
                                  children: [
                                    Expanded(child: SizedBox()),
                                    FadeTransition(
                                      opacity: opacityAnimation2,
                                      child: ShapedWidget3(
                                        tableCode: widget.tableCode,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),

                widget.isNew == true
                    ? Text(
                        "New!!",
                        style: TextStyle(fontSize: 22),
                      )
                    : Container(),

                Positioned(
                  height: 50,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
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
                      Expanded(child: SizedBox()),
                      PopupMenuButton<int>(
                          tooltip: '',
                          //splashRadius: 0.1,
                          onSelected: (val) => _onSelected(val),
                          color: globals.white,
                          itemBuilder: (context) => [
                                widget.isAdmin == true
                                    ? PopupMenuItem<int>(
                                        value: 0,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: globals.blue1,
                                            ),
                                            SizedBox(width: 5),
                                            Text('Delete Table'),
                                          ],
                                        ),
                                      )
                                    : PopupMenuItem<int>(
                                        enabled: false,
                                        child: SizedBox(),
                                      ),
                                widget.isPrivet == true
                                    ? PopupMenuItem<int>(
                                        value: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.group_outlined,
                                                color: globals.blue1,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Show Participant'),
                                            ],
                                          ),
                                        ),
                                      )
                                    : PopupMenuItem<int>(
                                        enabled: false,
                                        child: SizedBox(),
                                      ),
                                widget.isAdmin == true &&
                                        widget.isPrivet == true
                                    ? PopupMenuItem<int>(
                                        value: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person_add_outlined,
                                                color: globals.blue1,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Add Participant'),
                                            ],
                                          ),
                                        ),
                                      )
                                    : PopupMenuItem<int>(
                                        enabled: false,
                                        child: SizedBox(),
                                      ),
                              ]),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        print("reload sitOnChair");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load joinTable');
        var account_Id = await SessionManager().get('account_Id');

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
              widget.isControlPanel = true;
              _myPos = position - 1;
              widget.nb++;
              widget.imgs[position - 1] =
                  'https://picsum.photos/50/50/?${position - 1}'; //get img from server body[1]
              widget.enablee[position - 1] = true;
            });
          }
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error410") {
          ErrorPopup(context, globals.error410);
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
                  'https://picsum.photos/50/50/?${position - 1}'; //get img from server body[1]
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
      print('load sitOnChair end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }// Done

  Future<void> _startJit(String table_name, int position) async {
    if (_isInMeeting == false) {
      setState(() {
        _isInMeeting = true;
      });
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
          var username = await SessionManager().get('username');
          if (kIsWeb) {
            print('isWeb');
            // if (!await canLaunch(globals.jaasUrl +
            //     table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") +
            //     '&account=' +
            //     username.toString())) {
            try {
              final params = Uri.encodeFull(
                  globals.jaasUrl +
                               table_name +
                             '&account=' +
                             username.toString());

              String url = params.toString();
              await launch(url,
                  forceSafariVC: false,
                  forceWebView: false,
                  headers: <String, String>{
                    'my_header_key': 'my_header_value'
                  });

            } catch (e) {
              print(
                  'Could not launch ${globals.jaasUrl + table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") + '&account=' + username.toString()}');
            }
            // } else {
            //   throw 'Could not launch ${globals.jaasUrl + table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") + '&account=' + username.toString()}';
            // }
          } else if (Platform.isWindows ||
              Platform.isLinux ||
              Platform.isMacOS) {
            print('is' + Platform.operatingSystem);
            _webview = await WebviewWindow.create(
                configuration: CreateConfiguration(
              titleBarHeight: 0,
            ));
            _webview.launch(globals.jaasUrl +
                table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") +
                '&account=' +
                username.toString());
            // _webview.onClose.whenComplete(() {
            //   _leftOccupant();
            // });
          } else {
            print('is' + Platform.operatingSystem);
            try {
              await launch(
                  globals.jaasUrl +
                      table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") +
                      '&account=' +
                      username.toString(),
                  forceSafariVC: false,
                  forceWebView: false,
                  headers: <String, String>{
                    'my_header_key': 'my_header_value'
                  });
            } catch (e) {
              print(
                  'Could not launch ${globals.jaasUrl + table_name.replaceAll(new RegExp(r"\s+\b|\b\s"), "%20") + '&account=' + username.toString()}');
            }
          }
        } catch (e) {
          print(e);
          globals.loadJoinTableLibrary = false;
          ErrorPopup(context, globals.errorException);
          print(
              '=========<<======================================================<<==================================================<<=========');
        }
        globals.loadJoinTableLibrary = false;
        print('join jit end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }// Done

  Future<void> _leftOccupant() async {
    if (_isInMeeting == true) {
      try {
        setState(() {
          _isInMeeting = false;
        });
        print('Occupent left!!');
        var username = await SessionManager().get('username');
        if (kIsWeb) {
          print('isWeb');
          try {
            await closeWebView();// .then((value) => _leftOccupant())
          } catch (e) {
            print('Can\'t close web webview' + e.toString());
          }
        } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
          try {
            _webview.close();
            _webview.onClose.whenComplete(() {
              _leftOccupant();
            });
          } catch (e) {
            print('Can\'t close web webview' + e.toString());
          }
        } else {
          print('is' + Platform.operatingSystem);
          try {
            await closeWebView();// .then((value) => _leftOccupant())
          } catch (e) {
            print('Can\'t close mobile webview' + e.toString());
          }
        }
      } catch (e) {
        print(e);
        globals.loadJoinTableLibrary = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }// Done

  Future<void> _removeParticipant(int participantId) async {
    if (globals.loadJoinTableLibrary == false) {
          globals.loadJoinTableLibrary = true;
          while (globals.loadLibrary == true ||
              globals.loadCreateTableLibrary == true) {
            await Future.delayed(Duration(seconds: 1));
            print(
                '=========>>======================================================>>==================================================>>=========');
            print("reload leftOccupant");
            print(
                '=========<<======================================================<<==================================================<<=========');
          }

          try {
            print('load joinTable');
            var account_Id = await SessionManager().get('account_Id');

            var data = {
              'version': globals.version,
              'account_Id': account_Id,
              'table_id': widget.id,
              'participant_id': participantId,
            };

            var res = await CallApi().postData(data, '(Control)removeParticipant.php');
            print(res.body);
            List<dynamic> body = json.decode(res.body);

            if (body[0] == "success") {
              SuccessPopup(context, globals.success411);
            } else if (body[0] == "errorVersion") {
              ErrorPopup(context, globals.errorVersion);
            } else if (body[0] == "errorToken") {
              ErrorPopup(context, globals.errorToken);
            } else if (body[0] == "error4") {
              ErrorPopup(context, globals.error4);
            } else if (body[0] == "error7") {
              WarningPopup(context, globals.warning7);
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
          print('load leftOccupant end!!!');
          print(
              '=========<<======================================================<<==================================================<<=========');
        }
  }// ~Done

  Future<void> _removeTable() async {
    if (globals.loadJoinTableLibrary == false) {
      globals.loadJoinTableLibrary = true;
      while (globals.loadLibrary == true ||
          globals.loadCreateTableLibrary == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload removeTable");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load joinTable');
        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'table_id': widget.id,
        };

        var res = await CallApi().postData(data, '(Control)removeTable.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          SuccessPopup(context, globals.success412);
          widget.onRemoveTable(widget.id);
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
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
      print('load removeTable end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }// Done

  Future<void> _loadOccupants() async {
    widget.imgs = ['', '', '', '', '', '', '', ''];
    try {
      if (widget.getIds.contains(widget.account_Id.toString())) {
        _myPos = widget.getIds.indexOf(widget.account_Id.toString());
        print('_myPos:$_myPos');
      }
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
        // if (mounted) {
        //   setState(() {
        //     widget.nb--;
        //     widget.nb = 0;
        //   });
        // }
        //deload
        for (int i = 7; i >= 0; i--) {
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
  }// Done

  Future<void> _closeControlPanel() async {
    if (globals.loadJoinTableLibrary == false) {
      globals.loadJoinTableLibrary = true;
      while (globals.loadLibrary == true ||
          globals.loadCreateTableLibrary == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload controlPanel");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load joinTable');
        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'table_id': widget.id,
        };

        var res = await CallApi().postData(data, '(Control)removeOccupant.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          print('Occupant removed successfully.');
          if(mounted){
            setState(() {
              widget.imgs[_myPos] = '';
              widget.enablee[_myPos] = false;
              widget.nb = widget.nb - 1;
              _myPos = -9999;
              widget.isControlPanel = false;
            });
          }
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
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
      print('load controlPanel end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }



  }// Done

  _onSelected(int val) {
    switch (val) {
      case 0:
        _removeTable();
        setState(() {
          _edit = !_edit;
        });
        break;
      case 1:
        setState(() {
          if (_iconIsClicked2 == true) _iconIsClicked2 = false;
          _iconIsClicked = !_iconIsClicked;
          _edit = !_edit;
        });
        break;
      case 1:
        setState(() {
          if (_iconIsClicked == true) _iconIsClicked = false;
          _iconIsClicked2 = !_iconIsClicked2;
          _edit = !_edit;
        });
        break;
    }
  }
  static String encodeFull(String uri) {
    var _Uri;
    return _Uri._uriEncode(_Uri._encodeFullTable, uri, utf8, false);
  }


  // Done

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
//
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
