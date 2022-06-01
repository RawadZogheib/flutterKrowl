import 'dart:convert';

import 'package:Krowl/globals/globals.dart' as globals;
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


  NotificationContainer({Key? key,
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
  Color _boxColor =Colors.black12;
  GlobalKey _toolTipKey = GlobalKey();

  int val = -1;
  var color1 = Colors.grey.shade400;
  bool IconSelected = true;
  @override
  void initState() {
    _notificationType(widget.notification_type,widget.notification_status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 100,
          decoration: BoxDecoration(
          color:_boxColor,
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                        child: Row(
                          children: [
                            widget.notification_type==41?Row(
                              children: [
                                myBtn2(btnText: Text("Confirm"),height:35,width:95,onPress: () { _confirmRequest();},color1:globals.blue1,color2: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left:19.0),
                                  child: myBtn2(btnText: Text("Cancel"),height:35,width:95,onPress: () { _cancelRequest();},color1:Colors.white,color2: globals.blue1),
                                ),
                              ],
                            )
                                : Icon(
                              notification_icon,
                              color: globals.blue1,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.only(left: 8.0, bottom: 4),
                  //           child: Text(
                  //             widget.sender_name,
                  //             style: GoogleFonts.archivoBlack(
                  //                 fontWeight: FontWeight.bold, fontSize: 20),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 15,
                  //         ),
                  //         (SentFriendRequest == true
                  //             ? Icon(
                  //                 Icons.people,
                  //                 color: globals.blue1,
                  //                 size: 23,
                  //               )
                  //             : (AcceptedFriendRequest == true
                  //                 ? Icon(
                  //                     Icons.person_add_alt_1_rounded,
                  //                     color: globals.blue1,
                  //                     size: 23,
                  //                   )
                  //                 : (SentMessage == true
                  //                     ? Icon(
                  //                         Icons.chat_bubble,
                  //                         color: globals.blue1,
                  //                         size: 23,
                  //                       )
                  //                     : (StartedCall == true
                  //                         ? Icon(
                  //                             Icons.videocam,
                  //                             color: globals.blue1,
                  //                             size: 23,
                  //                           )
                  //                         : Container()))))
                  //       ],
                  //     ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 8.0),
                  //         child: (SentFriendRequest == true
                  //             ? Text("sent you a friend request",
                  //                 textAlign: TextAlign.center,
                  //                 style: GoogleFonts.nunito(
                  //                     fontSize: 17, color: Colors.black))
                  //             : (AcceptedFriendRequest == true
                  //                 ? Text("accepted your friend request",
                  //                     textAlign: TextAlign.center,
                  //                     style: GoogleFonts.nunito(
                  //                         fontSize: 17, color: Colors.black))
                  //                 : (SentMessage == true
                  //                     ? Text("sent you a message",
                  //                         textAlign: TextAlign.center,
                  //                         style: GoogleFonts.nunito(
                  //                             fontSize: 17,
                  //                             color: Colors.black))
                  //                     : (StartedCall == true
                  //                         ? Text("started a call",
                  //                             textAlign: TextAlign.center,
                  //                             style: GoogleFonts.nunito(
                  //                                 fontSize: 17,
                  //                                 color: Colors.black))
                  //                         : Container())))),
                  //       ),
                  //   ],
                  // )
                ],
              ),
            ],
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
        notification_icon = Icons.insert_emoticon_outlined;
        break;

      case 33: // Like/Unlike a Reply
        notification_context = "reacted to your reply";
        notification_icon = Icons.insert_emoticon_outlined;
        break;

      case 41: // Sending a Friendship Request
        notification_context = "sent you a friend request";
        //notification_icon = Icons.people;
        break;

      case 42: // Acccepting a Friendship Request
        notification_context = " accepted your friend request";
        notification_icon = Icons.people;
        break;
    }
    if(status == 2) {
      _boxColor=Colors.white;
    }
  }
  _cancelRequest() async {
    //print(widget.notification_params["receiver"]);
    var account_Id = await SessionManager().get('account_Id');
    var data = {'version': globals.version, 'account_Id': account_Id,'friend_id':widget.sender_id};
    var res = await CallApi()
        .postData(data, '(Control)cancelFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
  }

  Future<void> _confirmRequest() async {
    var account_Id = await SessionManager().get('account_Id');
    var data = {'version': globals.version, 'account_Id': account_Id,'friend_id':widget.sender_id};
    var res = await CallApi()
        .postData(data, '(Control)confirmFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
  }
}