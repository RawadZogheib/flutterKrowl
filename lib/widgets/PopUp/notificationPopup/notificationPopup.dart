import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/MyCustomScrollBehavior.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/PopUp/notificationPopup/notificationPopupChildren.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class ShapedWidget extends StatelessWidget {
  //ShapedWidget();

  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Center(
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: _ShapedWidgetBorder(
                borderRadius: BorderRadius.all(Radius.circular(padding)),
                padding: padding),
            elevation: 4.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250.0,
                height: 400.0,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      NotificationPopupChildren(),
                      GestureDetector(
                        onTap: () => print('Show More'),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Show More',
                            style: TextStyle(color: globals.blue1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class _ShapedWidgetBorder extends RoundedRectangleBorder {
  _ShapedWidgetBorder({
    required this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(side: side, borderRadius: borderRadius);
  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width - 65.0, rect.top)
      ..lineTo(rect.width - 78.0, rect.top - 16.0)
      ..lineTo(rect.width - 89.0, rect.top)
      ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height - padding)));
  }
}

class ShapedWidget2 extends StatefulWidget {
  bool isAdmin;
  int account_Id;
  String tableId;
  List<dynamic> getIdsPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getUsersPrivet = ['', '', '', '', '', '', '', ''];
  List<dynamic> getImgsPrivet = ['', '', '', '', '', '', '', ''];

  ShapedWidget2({
    required this.isAdmin,
    required this.account_Id,
    required this.tableId,
    required this.getIdsPrivet,
    required this.getUsersPrivet,
    required this.getImgsPrivet,
  });

  @override
  State<ShapedWidget2> createState() => _ShapedWidget2State();
}

class _ShapedWidget2State extends State<ShapedWidget2> {
  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  width: 305,
                  height: 300,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: globals.blue1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Table Participants',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: MyCustomScrollBehavior()
                              .copyWith(scrollbars: false),
                          child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: widget.getIdsPrivet.length,
                            itemBuilder: (context, index) {
                              return Member(
                                index: index,
                                account_Id: widget.account_Id,
                                tableId: widget.tableId,
                                isAdmin: widget.isAdmin,
                                idsPrivet: widget.getIdsPrivet[index],
                                usersPrivet: widget.getUsersPrivet[index],
                                imgsPrivet: widget.getImgsPrivet[index],
                                removeParticipant: (String participantId) =>
                                    _removeParticipant(participantId),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  _removeParticipant(String participantId) {
    int _index = widget.getIdsPrivet.indexOf(participantId);
    if (mounted) {
      setState(() {
        widget.getIdsPrivet.removeAt(_index);
        widget.getUsersPrivet.removeAt(_index);
        widget.getImgsPrivet.removeAt(_index);
      });
    }
  }
}

class Member extends StatefulWidget {
  int index;
  int account_Id;
  String tableId;
  bool isAdmin;
  String idsPrivet;
  String usersPrivet;
  String imgsPrivet;
  Function removeParticipant;

  Member({
    required this.index,
    required this.account_Id,
    required this.tableId,
    required this.isAdmin,
    required this.idsPrivet,
    required this.usersPrivet,
    required this.imgsPrivet,
    required this.removeParticipant,
  });

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.isAdmin == true &&
                  int.parse(widget.idsPrivet) != widget.account_Id
              ? Row(
                  children: [
                    InkWell(
                      onTap: () => _removeParticipant(),
                      child: Icon(Icons.delete),
                    ),
                    SizedBox(width: 15),
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.transparent,
                    ),
                    SizedBox(width: 15),
                  ],
                ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: globals.blue1,
                  backgroundImage: NetworkImage(widget.imgsPrivet),
                  maxRadius: 20,
                ),
              ),
              widget.index == 0
                  ? Positioned(
                      top: -9.5,
                      left: 0,
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(-12 / 360),
                        child: Image.asset(
                          'Assets/crown.PNG',
                          height: 25,
                          width: 25,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.usersPrivet,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Future<void> _removeParticipant() async {
    if (globals.loadJoinTableLibrary == false) {
      globals.loadJoinTableLibrary = true;
      while (globals.loadLibrary == true ||
          globals.loadCreateTableLibrary == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload removeParticipant");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      try {
        print('load removeParticipant');
        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'table_id': widget.tableId,
          'participant_id': widget.idsPrivet,
        };

        var res =
            await CallApi().postData(data, '(Control)removeParticipant.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          widget.removeParticipant(widget.idsPrivet);
          SuccessPopup(context, globals.success415);
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else if (body[0] == "error417") {
          ErrorPopup(context, globals.error417);
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
      print('load removeParticipant end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }
}

class ShapedWidget3 extends StatelessWidget {
  final double padding = 4.0;
  String tableCode;

  ShapedWidget3({
    required this.tableCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  width: 315,
                  height: 200,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: globals.blue1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ScrollConfiguration(
                    behavior:
                        MyCustomScrollBehavior().copyWith(scrollbars: false),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Table Id: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.blue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                        ClipboardData(text: tableCode))
                                    .then((value) {
                                  print('copy');
                                });
                              },
                              child: Text(
                                tableCode,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'or',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text:
                                        'https://krowl.dataflow.com.lb:8070/?private=' +
                                            tableCode))
                                .then((value) {
                              SuccessPopup(
                                  context, 'Link copied successfully.');
                              print('copy');
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: globals.blue2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Link: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: globals.blue1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'https://krowl.dataflow.com.lb:8070/?private=' +
                                      tableCode,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
