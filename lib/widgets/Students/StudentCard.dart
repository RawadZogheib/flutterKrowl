import 'dart:convert';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/page/Students/StudentProfile.dart';
import 'package:Krowl/widgets/PopUp/Loading/LoadingRequestAddUnFriendPopUp.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/Students/Students1/StudentButton.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentCard extends StatefulWidget {
  String userId;
  String username;
  String universityName;
  String description;
  int nbrOfFriends;
  String isFriend;
  BuildContext contextStudentPage;
  var userImg;
  var color1; //light
  var color2; //dark
  var onTap;

  StudentCard({
    required this.userId,
    required this.username,
    required this.universityName,
    required this.description,
    required this.nbrOfFriends,
    required this.isFriend,
    required this.contextStudentPage,
    this.userImg,
    this.color1,
    this.color2,
    this.onTap,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool _loadButton = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => StudentProfile(
                userId: widget.userId,
                username: widget.username,
                universityName: widget.universityName,
                description: widget.description,
                nbrOfFriends: widget.nbrOfFriends,
                isFriend: widget.isFriend,
              ),
            ),
            (route) => false);
      },
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 280,
        width: 310,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                Column(
                  children: [
                    Image(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      image: AssetImage('Assets/CoverPhoto.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                ),
                Positioned(
                  top: 50,
                  child: widget.userImg.isEmpty
                      ? Avatar(
                          elevation: 3,
                          shape: AvatarShape.circle(27),
                          name: '${widget.username}',
                          placeholderColors: [globals.blue1],
                        )
                      : Image.network(globals.myIP + '/' + widget.userImg),
                ),
              ]),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                          title: Center(
                              child: Text(
                            "${widget.username}",
                            style: GoogleFonts.archivoBlack(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                          subtitle: Center(
                              child: Text("${widget.universityName}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600)))),
                    ),
                    widget.isFriend == '0' // Not Friend
                        ? Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(bottom: 15, right: 15),
                                    child: StudentButton(
                                      height: 25,
                                      fontSize: 12.0,
                                      text: "Add Friend",
                                      textcolor: globals.blue1,
                                      color1: globals.blue2,
                                      color2: Colors.blueGrey,
                                      onPressed: () async {
                                        await _addFriend();
                                      },
                                    )),
                              ],
                            ),
                          )
                        : widget.isFriend == '1' // Requested
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: 15, right: 15),
                                        child: StudentButton(
                                          fontSize: 12.0,
                                          height: 25,
                                          text: "Requested",
                                          textcolor: globals.blue1,
                                          color1: globals.blue2,
                                          color2: Colors.blueGrey,
                                          onPressed: () async {
                                            await _requested();
                                          },
                                        )),
                                  ],
                                ),
                              )
                            : widget.isFriend == '2' // Friend
                                ? Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                bottom: 15, left: 10, right: 6),
                                            child: StudentButton(
                                              fontSize: 12.0,
                                              height: 25,
                                              text: "Unfriend",
                                              textcolor: globals.blue1,
                                              color1: globals.blue2,
                                              color2: Colors.blueGrey,
                                              onPressed: () async {
                                                await _unFriend();
                                              },
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                bottom: 15, right: 15),
                                            child: StudentButton(
                                              height: 25,
                                              fontSize: 12.0,
                                              text: "Message",
                                              textcolor: globals.blue1,
                                              color1: globals.blue2,
                                              color2: Colors.blueGrey,
                                              onPressed: () {
                                                _goToMessage();
                                              },
                                            )),
                                      ],
                                    ),
                                  )
                                : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addFriend() async {
    //Add Friend
    if (_loadButton == false) {
      LoadingRequestAddUnFriendPopUp('Adding friend...', context);
      _loadButton = true;
      while (globals.loadStudent == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload Button");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      try {
        globals.loadButtonStudent = true;
        print(
            '=========>>======================================================>>==================================================>>=========');
        print('Sending like to server...');

        //send to server
        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'friend_id': widget.userId,
        };

        var res = await CallApi().postData(data, '(Control)requestFriends.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        Navigator.pop(context);

        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              widget.isFriend = '1';
            });
          }

          MotionToast(
            icon: CupertinoIcons.checkmark_alt_circle,
            primaryColor: globals.blue2,
            secondaryColor: globals.blue1,
            toastDuration: Duration(seconds: 3),
            backgroundType: BACKGROUND_TYPE.solid,
            title: Text(
              'Success',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text('Friend request sent Successfully'),
            position: MOTION_TOAST_POSITION.bottom,
            animationType: ANIMATION.fromRight,
            height: 100,
          ).show(widget.contextStudentPage);

          print('addFriend Success');
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else {
          _loadButton = false;
          Navigator.pop(context);
          globals.loadButtonStudent = false;
          ErrorPopup(context, globals.errorElse);
        }
        _loadButton = false;
        globals.loadButtonStudent = false;
        print('load button end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print(e);
        _loadButton = false;
        Navigator.pop(context);
        globals.loadButtonStudent = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }

  void _goToMessage() {
    //Go To Message
  }

  _requested() async {
    //Remove Request
    await _cancelFriend(
        'Friend request removed Successfully', 'Removing friend request...');
  }

  _unFriend() async {
    //Remove From Friend List
    await _cancelFriend('Friend removed Successfully', 'Removing friend...');
  }

  _cancelFriend(String text, String text2) async {
    //Add Friend
    if (_loadButton == false) {
      LoadingRequestAddUnFriendPopUp(text2, context);
      _loadButton = true;
      while (globals.loadStudent == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload Button");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      try {
        globals.loadButtonStudent = true;
        var account_Id = await SessionManager().get('account_Id');

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'friend_id': widget.userId,
        };

        var res = await CallApi().postData(data, '(Control)cancelFriends.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        Navigator.pop(context);

        if (body[0] == "success") {
          if (mounted) {
            setState(() {
              widget.isFriend = '0';
            });
          }
          // for (int i = 0; i < globals.children.length; i++) {
          //   if (globals.children[i].userId == body[1]) {
          //     setState(() {
          //       globals.children[i].isFriend = '0';
          //     });
          //   }
          // }
          MotionToast(
            icon: CupertinoIcons.checkmark_alt_circle,
            primaryColor: globals.blue2,
            secondaryColor: globals.blue1,
            toastDuration: Duration(seconds: 3),
            backgroundType: BACKGROUND_TYPE.solid,
            title: Text(
              'Success',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text(text),
            position: MOTION_TOAST_POSITION.bottom,
            animationType: ANIMATION.fromRight,
            height: 100,
          ).show(widget.contextStudentPage);

          print('cancelFriend Success');
        } else if (body[0] == "errorVersion") {
          ErrorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          ErrorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          ErrorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          WarningPopup(context, globals.warning7);
        } else {
          _loadButton = false;
          Navigator.pop(context);
          globals.loadButtonStudent = false;
          ErrorPopup(context, globals.errorElse);
        }
        globals.loadButtonStudent = false;
        _loadButton = false;
        print('load button end!!!');
        print(
            '=========<<======================================================<<==================================================<<=========');
      } catch (e) {
        print(e);
        _loadButton = false;
        Navigator.pop(context);
        globals.loadButtonStudent = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }
  }
}

//InkWell(
//               onTap: onTap,
//               child: Transform.rotate(
//                 angle: -180 * 3.14159265359 / 180,),
//             ),
