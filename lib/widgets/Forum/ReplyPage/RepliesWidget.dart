import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Replies extends StatefulWidget {
  var id;
  var postId;
  var reply;
  var username;
  int val;
  var date;
  Color color;
  Color color2;

  Replies({
    required this.id,
    required this.postId,
    required this.reply,
    required this.username,
    required this.val,
    required this.date,
    required this.color,
    required this.color2,
  });

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  bool _loadLike = false;
  bool _loadDislike = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('Assets/userImage4.jpeg'),
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
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 660,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 30, right: 15),
                    child: Text(
                      widget.reply, // this is the reply answer
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
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  _onLike() async {
    _loadLike = true;
    while (globals.loadReplyPage == true || globals.loadCreateReplyPage == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload like");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      globals.loadLikeDislikeReplyPage = true;
      print(
          '=========>>======================================================>>==================================================>>=========');
      print('Sending like to server...');

      //send to server
      var account_Id = await SessionManager().get('account_Id');

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'reply_id': widget.id,
        'post_id': widget.postId,
        'like_val': '1',
      };

      var res = await CallApi().postData(data, '(Control)likeReplies.php');
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
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "error4") {
        errorPopup(context, globals.error4);
      } else if (body[0] == "error7") {
        warningPopup(context, globals.warning7);
      } else {
        _loadLike = false;
        globals.loadLikeDislikeReplyPage = false;
        errorPopup(context, globals.errorElse);
      }

      _loadLike = false;
      globals.loadLikeDislikeReplyPage = false;
      print('load like end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadLike = false;
      globals.loadLikeDislikeReplyPage = false;
      errorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _onDislike() async {
    _loadDislike = true;
    while (globals.loadReplyPage == true || globals.loadCreateReplyPage == true) {
      await Future.delayed(Duration(seconds: 1));
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("reload dislike");
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
    try {
      globals.loadLikeDislikeReplyPage = true;
      print(
          '=========>>======================================================>>==================================================>>=========');
      print('Sending dislike to server...');
      //send to server
      var account_Id = await SessionManager().get('account_Id');

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'reply_id': widget.id,
        'post_id': widget.postId,
        'like_val': '-1',
      };

      var res = await CallApi().postData(data, '(Control)likeReplies.php');
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
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "error4") {
        errorPopup(context, globals.error4);
      } else if (body[0] == "error7") {
        warningPopup(context, globals.warning7);
      } else {
        _loadDislike = false;
        globals.loadLikeDislikeReplyPage = false;
        errorPopup(context, globals.errorElse);
      }

      globals.loadLikeDislikeReplyPage = false;
      _loadDislike = false;
      print('load dislike end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    } catch (e) {
      print(e);
      _loadDislike = false;
      globals.loadLikeDislikeReplyPage = false;
      errorPopup(context, globals.errorException);
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }
}
