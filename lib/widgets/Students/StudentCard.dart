import 'dart:convert';
import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/Students/Students1/StudentButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentCard extends StatefulWidget {
  String userId;
  String username;
  String universityname;
  String isFriend;
  BuildContext contextStudentPage;
  var userImg;
  var color1; //light
  var color2; //dark
  var onTap;
  var reload;

  StudentCard({
    required this.userId,
    required this.username,
    required this.universityname,
    required this.isFriend,
    required this.contextStudentPage,
    this.userImg,
    this.color1,
    this.color2,
    this.onTap,
    required this.reload,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/StudentProfile');
        print("Click");
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
                              child: Text("${widget.universityname}",
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
                                        if (globals.onClickLoad == false) {
                                          globals.onClickLoad = true;
                                          await _addFriend();
                                          globals.onClickLoad = false;
                                        }
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
                                          text: "Requetsed",
                                          textcolor: globals.blue1,
                                          color1: globals.blue2,
                                          color2: Colors.blueGrey,
                                          onPressed: () async {
                                            if (globals.onClickLoad == false) {
                                              globals.onClickLoad = true;
                                              await _requested();
                                              globals.onClickLoad = false;
                                            }
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
                                                if (globals.onClickLoad ==
                                                    false) {
                                                  globals.onClickLoad = true;
                                                  await _unFriend();
                                                  globals.onClickLoad = false;
                                                }
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
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'friend_id': widget.userId,
    };

    var res = await CallApi().postData(data, '(Control)requestFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      if (mounted) {
        setState(() {
          widget.isFriend = '1';
        });
      }else{
        widget.reload();
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
    }

  }

  void _goToMessage() {
    //Go To Message
  }

  _requested() async {
    //Remove Request
    await _cancelFriend('Friend request removed Successfully');
  }

  _unFriend() async {
    //Remove From Friend List
    await _cancelFriend('Friend removed Successfully');
  }

  _cancelFriend(String text) async {
    //Add Friend
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'friend_id': widget.userId,
    };

    var res = await CallApi().postData(data, '(Control)cancelFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      if (mounted) {
        setState(() {
          widget.isFriend = '0';
        });
      }else{
        widget.reload();
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
    }
  }
}

//InkWell(
//               onTap: onTap,
//               child: Transform.rotate(
//                 angle: -180 * 3.14159265359 / 180,),
//             ),
