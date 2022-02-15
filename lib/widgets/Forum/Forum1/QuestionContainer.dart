import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Forum/ReplyPage.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question extends StatefulWidget {
  var height;
  var width;
  String id;
  String username;
  String tag;
  String text;
  String question_context;

  // bool like;
  // bool dislike;

  int val;
  Color color;
  Color color2;
  var date;
  var onTap;

  Question(
      {this.height,
      this.width,
      required this.id,
      required this.username,
      required this.tag,
      required this.text,
      required this.val,
      required this.color,
      required this.color2,
      required this.date,
      required this.question_context,
      this.onTap});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool _loadLike = false;
  bool _loadDislike = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      splashColor: globals.blue1,
      hoverColor: globals.blue1.withOpacity(0.5),
      onTap: () => _openReply(),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.62,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('#${widget.tag}',
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Rubik',
                              color: globals.blue1)),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      alignment: Alignment.topLeft,
                      child: Text(widget.text,
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("Assets/userImage1.jpeg"),
                            maxRadius: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.username,
                          style: TextStyle(color: globals.blue1, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
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
          ),
        ],
      ),
    );
  }

  _onLike() async {
    while (globals.loadForm1 == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload like");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      _loadLike = true;
      globals.loadLikeDislikeForm1 = true;
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
        globals.loadLikeDislikeForm1 = false;
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
      globals.loadLikeDislikeForm1 = false;
      _loadLike = false;
      print('load like end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadLike = false;
      globals.loadLikeDislikeForm1 = false;
      ErrorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _onDislike() async {
    while (globals.loadForm1 == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload dislike");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      _loadDislike = true;
      globals.loadLikeDislikeForm1 = true;
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
        globals.loadLikeDislikeForm1 = false;
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
      globals.loadLikeDislikeForm1 = false;
      _loadDislike = false;
      print('load dislike end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadDislike = false;
      globals.loadLikeDislikeForm1 = false;
      ErrorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _openReply() {
    globals.currentPage = 'Forum(1)';
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ReplyPage(
              id: widget.id,
              question: widget.text,
              subject: widget.tag,
              username: widget.username,
              val: widget.val,
              color: widget.color,
              color2: widget.color2,
              contextQuestion: widget.question_context,
              date: widget.date),
        ),
        (route) => false);
  }
}
