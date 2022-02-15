import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedReplyContainer extends StatefulWidget {
  String id;
  String question;
  String subject;
  String username;
  var val;
  var date;
  Color color;
  Color color2;
  String contextQuestion;
  var onTap;

  DetailedReplyContainer(
      {required this.id,
      required this.question,
      required this.subject,
      required this.username,
      required this.val,
      required this.contextQuestion,
      required this.date,
      required this.color,
      required this.color2,
      required this.onTap});

  @override
  State<DetailedReplyContainer> createState() => _DetailedReplyContainerState();
}

class _DetailedReplyContainerState extends State<DetailedReplyContainer> {
  bool _loadLike = false;
  bool _loadDislike = false;
  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 110.0, bottom: 15),
          child: Text(
            widget.question, // this is the question
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(widget.subject, //this is the subject of the quest
              style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Rubik',
                  color: globals.blue1)),
        ),
        Container(
          height: 0.3,
          width: 700.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('Assets/userImage1.jpeg'),
                maxRadius: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                widget.username, //this is the username
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Rubik'),
              ),
            ),
            Text(
              widget.date, //this is the date
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Rubik',
                  color: Colors.grey.shade700),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 660,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 45, bottom: 30, right: 15),
                  child: Text(
                    widget.contextQuestion,
                    style: GoogleFonts.nunito(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    if (_loadLike == false && _loadDislike == false) {
                      await _onLike();
                    }
                  },
                  child: Icon(
                    Icons.thumb_up,
                    color: widget.color,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('${widget.val.toString()}'),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    if (_loadLike == false && _loadDislike == false) {
                      await _onDislike();
                    }
                  },
                  child: Icon(
                    Icons.thumb_down,
                    color: widget.color2,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('Assets/userImage2.jpeg'),
              maxRadius: 20,
            ),
            Container(
              width: 660,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 60),
                child: Container(
                  child: TextInput1(
                      controller: nameHolder,
                      fillColor: Colors.white,
                      focusColor: Colors.transparent,
                      cursorColor: Colors.transparent,
                      hintText: 'Type here to reply to ${widget.username} ',
                      onChanged: (val) {
                        globals.reply_data = val;
                        print(globals.reply_data.toString());
                      }),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 50),
          child: Container(
              width: 120,
              child: AskQuestionButton(
                  text: 'Reply',
                  textcolor: globals.blue1,
                  color1: globals.blue2,
                  color2: Colors.grey,
                  onPressed: () {
                    clearTextInput();
                    _createReply();
                  })),
        )
      ],
    );
  }

  _createReply() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");

    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'post_id': widget.id,
      'reply_data': globals.reply_data,
    };

    var res = await CallApi().postData(data, '(Control)createReply.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      widget.onTap('33'); // get reply id from php body[2]
      //toast success
      //show on forum1
    } else if (body[0] == "errorVersion") {
      ErrorPopup(context, globals.errorVersion);
    } else if (body[0] == "errorToken") {
      ErrorPopup(context, globals.errorToken);
    } else if (body[0] == "error7") {
      WarningPopup(context, globals.warning7);
    }
  }

  _onLike() async {
    while (globals.loadReplyPage == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload like");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      _loadLike = true;
      globals.loadLikeDislikeReplyPage = true;
      print(
          '=========>>======================================================>>==================================================>>=========');
      print('Sending like to server...');

      //send to server
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var account_Id = localStorage.getString("account_Id");

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'post_id': widget.id,
        'like_val': '1',
      };

      var res = await CallApi().postData(data, '(Control)likePosts.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        if (mounted) {
          setState(() {
            if (int.parse(body[1]) == 0) {
              widget.color = Colors.grey.shade600;
              widget.color2 = Colors.grey.shade600;
            } else if (int.parse(body[1]) == 1) {
              widget.color = globals.blue1;
              widget.color2 = Colors.grey.shade600;
            } else if (int.parse(body[1]) == -1) {
              widget.color = Colors.grey.shade600;
              widget.color2 = globals.blue1;
            }
            widget.val = int.parse(body[2]);
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
        _loadLike = false;
        globals.loadLikeDislikeReplyPage = false;
        ErrorPopup(context, globals.errorElse);
      }
      //
      //await Future.delayed(Duration(seconds: 10));

      // if (widget.like == false) {
      //   if (widget.dislike == false) {
      //     setState(() {
      //       widget.val += 1;
      //       widget.like = true;
      //       widget.color = globals.blue1;
      //       widget.color2 = Colors.grey.shade600;
      //     });
      //   } else {
      //     setState(() {
      //       widget.val += 2;
      //       widget.like = true;
      //       widget.dislike = false;
      //       widget.color = globals.blue1;
      //       widget.color2 = Colors.grey.shade600;
      //     });
      //   }
      // } else {
      //   setState(() {
      //     widget.val -= 1;
      //     widget.like = false;
      //     widget.color = Colors.grey.shade600;
      //     widget.color2 = Colors.grey.shade600;
      //   });
      // }
      globals.loadLikeDislikeReplyPage = false;
      _loadLike = false;
      print('load like end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadLike = false;
      globals.loadLikeDislikeReplyPage = false;
      ErrorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _onDislike() async {
    while (globals.loadReplyPage == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload dislike");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      _loadDislike = true;
      globals.loadLikeDislikeReplyPage = true;
      print(
          '=========>>======================================================>>==================================================>>=========');
      print('Sending dislike to server...');
      //send to server
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var account_Id = localStorage.getString("account_Id");

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'post_id': widget.id,
        'like_val': '-1',
      };

      var res = await CallApi().postData(data, '(Control)likePosts.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        if (mounted) {
          setState(() {
            if (int.parse(body[1]) == 0) {
              widget.color = Colors.grey.shade600;
              widget.color2 = Colors.grey.shade600;
            } else if (int.parse(body[1]) == 1) {
              widget.color = globals.blue1;
              widget.color2 = Colors.grey.shade600;
            } else if (int.parse(body[1]) == -1) {
              widget.color = Colors.grey.shade600;
              widget.color2 = globals.blue1;
            }
            widget.val = int.parse(body[2]);
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
        _loadDislike = false;
        globals.loadLikeDislikeReplyPage = false;
        ErrorPopup(context, globals.errorElse);
      }
      //
      //await Future.delayed(Duration(seconds: 10));

      // if (widget.dislike == false) {
      //   if (widget.like == false) {
      //     setState(() {
      //       widget.val -= 1;
      //       widget.dislike = true;
      //       widget.color = Colors.grey.shade600;
      //       widget.color2 = globals.blue1;
      //     });
      //   } else {
      //     setState(() {
      //       widget.val -= 2;
      //       widget.dislike = true;
      //       widget.like = false;
      //       widget.color = Colors.grey.shade600;
      //       widget.color2 = globals.blue1;
      //     });
      //   }
      // } else {
      //   setState(() {
      //     widget.val += 1;
      //     widget.dislike = false;
      //     widget.color = Colors.grey.shade600;
      //     widget.color2 = Colors.grey.shade600;
      //   });
      // }
      globals.loadLikeDislikeReplyPage = false;
      _loadDislike = false;
      print('load dislike end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadDislike = false;
      globals.loadLikeDislikeReplyPage = false;
      ErrorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }
}
