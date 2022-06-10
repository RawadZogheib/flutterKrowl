import 'dart:convert';

import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Forum/ReplyPage.dart';
import 'package:Krowl/page/Students/StudentProfile.dart';
import 'package:Krowl/widgets/Buttons/myButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/my_api.dart';

class NotificationContainer extends StatefulWidget {
  int notification_id;
  int sender_id;
  var sender_name;
  int notification_type;
  int notification_status;
  var notification_params;

  NotificationContainer(
      {Key? key,
      required this.notification_id,
      required this.sender_id,
      required this.sender_name,
      required this.notification_type,
      required this.notification_status,
      required this.notification_params});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  String notification_context = "";
  var notification_icon;
  Color _boxColor = Colors.black12;

  GlobalKey _toolTipKey = GlobalKey();

  int val = -1;
  var color1 = Colors.grey.shade400;
  bool IconSelected = true;
  var _children = <Widget>[];

  @override
  void initState() {
    _notificationType(widget.notification_type, widget.notification_status);
    if (widget.notification_type == 41) {
      _init();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _changeToWhite();
            if (widget.notification_type == 31 ||
                widget.notification_type == 32 ||
                widget.notification_type == 33) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReplyPage(
                      id: widget.notification_params["post"][0],
                      question: widget.notification_params["post"][1],
                      subject: widget.notification_params["post"][2],
                      username: widget.notification_params["post"][3],
                      val: int.parse(widget.notification_params["post"][4]),
                      color: Colors.grey,
                      color2: Colors.blue,
                      contextQuestion: widget.notification_params["post"][5],
                      date: widget.notification_params["post"][6],
                      reply_id: widget.notification_params["reply"],
                    ),
                  ),
                  (route) => false);
            } else if (widget.notification_type == 41 ||
                widget.notification_type == 42) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentProfile(
                      userId: widget.sender_id.toString(),
                      username: widget.notification_params["info"][0],
                      universityName: widget.notification_params["info"][1],
                      description: widget.notification_params["info"][2],
                      isFriend: widget.notification_params["info"][3],
                      nbrOfFriends:
                          int.parse(widget.notification_params["info"][4]),
                    ),
                  ),
                  (route) => false);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: 100,
            decoration: BoxDecoration(
              color: _boxColor,
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     final dynamic tooltip = _toolTipKey.currentState;
                    //     tooltip.ensureTooltipVisible();
                    //   },
                    //   child: Tooltip(
                    //       key: _toolTipKey,
                    //       message: 'Mark as unread',
                    //       child: IconSelected == true ?
                    //       IconButton(
                    //           splashRadius: 0.1,
                    //           iconSize: 20,
                    //           color: color1,
                    //           icon: Icon(Icons.bookmark_outlined),
                    //           onPressed: () {
                    //             setState(() {
                    //               color1 = globals.blue1;
                    //               IconSelected = true;
                    //             });
                    //           }):
                    //       IconButton(
                    //           splashRadius: 0.1,
                    //           iconSize: 20,
                    //           color: color1,
                    //           icon: Icon(Icons.bookmark_outlined),
                    //           onPressed: () {
                    //             setState(() {
                    //               color1 = Colors.grey.shade400;
                    //             });
                    //           })
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("Assets/userImage1.jpeg"),
                        maxRadius: 30,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, bottom: 4),
                                child: Text(
                                  widget.sender_name,
                                  style: GoogleFonts.archivoBlack(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(notification_context,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontSize: 17, color: Colors.black))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: widget.notification_type == 41
                              ? Wrap(
                            children: _children, // My Children
                          )
                              : Icon(
                            notification_icon,
                            color: globals.blue1,
                            size: 23,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 5.0),
                        //   child: Row(
                        //     children: [
                        //       widget.notification_type == 41
                        //           ? Row(
                        //               children: [
                        //                 myBtn2(
                        //                     btnText: Text("Confirm"),
                        //                     height: 35,
                        //                     width: 95,
                        //                     onPress: () {
                        //                       _confirmRequest();
                        //                     },
                        //                     color1: globals.blue1,
                        //                     color2: Colors.white),
                        //                 Padding(
                        //                   padding:
                        //                       const EdgeInsets.only(left: 19.0),
                        //                   child: myBtn2(
                        //                       btnText: Text("Cancel"),
                        //                       height: 35,
                        //                       width: 95,
                        //                       onPress: () {
                        //                         _cancelRequest();
                        //                       },
                        //                       color1: Colors.white,
                        //                       color2: globals.blue1),
                        //                 ),
                        //               ],
                        //             )
                        //           : Icon(
                        //               notification_icon,
                        //               color: globals.blue1,
                        //               size: 23,
                        //             ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _notificationType(int type, int status) {
    switch (type) {
      case 31: // Create a Reply
        notification_context = "replied to your post";
        notification_icon = Icons.insert_comment_sharp;
        break;

      case 32: // Like/Unlike a Post
        notification_context = "reacted to your post";
        if (widget.notification_params["like"] == "1")
          notification_icon = Icons.thumb_up_alt_outlined;
        else
          notification_icon = Icons.thumb_down_alt_outlined;
        break;

      case 33: // Like/Unlike a Reply
        notification_context = "reacted to your reply";
        if (widget.notification_params["like"] == "1")
          notification_icon = Icons.thumb_up_alt_outlined;
        else
          notification_icon = Icons.thumb_down_alt_outlined;
        break;

      case 41: // Sending a Friendship Request
        notification_context = "sent you a friend request";
        // notification_icon = Icons.people;
        break;

      case 42: // Acccepting a Friendship Request
        notification_context = "accepted your friend request";
        notification_icon = Icons.people;
        break;
    }
    if (status == 2 || status == 4) {
      _boxColor = Colors.white;
    }
  }

  _cancelRequest() async {
    //print(widget.notification_params["receiver"]);
    var account_Id = await SessionManager().get('account_Id');
    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'friend_id': widget.sender_id,

    };
    var res = await CallApi().postData(data, '(Control)cancelFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    if (body[0] == 'success') {
      _children.removeAt(0);
      _children.add(Text("Request removed"));
      setState(() {
        _children;
      });
    }
  }

  Future<void> _confirmRequest() async {
    var account_Id = await SessionManager().get('account_Id');
    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'friend_id': widget.sender_id
    };
    var res = await CallApi().postData(data, '(Control)confirmFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    if (body[0] == 'success') {
      _children.removeAt(0);
      _children.add(Text("You are now friends!"));
      setState(() {
        _children;
      });
    }
  }

  void _init() {
    _children.add(Row(
      children: [
        myBtn2(
            btnText: Text("Confirm"),
            height: 35,
            width: 95,
            onPress: () {
              _confirmRequest();
            },
            color1: globals.blue1,
            color2: Colors.white),
        Padding(
          padding: const EdgeInsets.only(left: 19.0),
          child: myBtn2(
              btnText: Text("Cancel"),
              height: 35,
              width: 95,
              onPress: () {
                _cancelRequest();
              },
              color1: Colors.white,
              color2: globals.blue1),
        ),
      ],
    ));
    setState(() {
      _children;
    });
  }

  Future<void> _changeToWhite() async {
    var account_Id = await SessionManager().get('account_Id');
    int status_after;
    if(widget.notification_status == 3 || widget.notification_status == 4) status_after=4;
    else status_after=2;

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'notif_id': widget.notification_id,
      'status_after':status_after
    };
    print("DATAAAAA"+data.toString());
    var res = await CallApi().postData(data, 'Notification/(Control)updateNotifStatus.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    if (body[0] == 'success') {
      setState(() {
        _boxColor=Colors.white;
      });
    }
  }
}
