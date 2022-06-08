import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/TextInput1.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedReplyContainer extends StatefulWidget {
  var id;
  var question;
  var subject;
  var username;
  int val;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearTextInput();
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
          child: Text('#${widget.subject}', //this is the subject of the quest
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
                      spaceAllowed: true,
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
    if (globals.loadCreateReplyPage == false) {
    globals.loadCreateReplyPage = true;
      while (globals.loadReplyPage == true ||
          globals.loadLikeDislikeReplyPage == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload createReplyPage");
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
      try {
        print('load createReplyPage');

        var account_Id = await SessionManager().get('account_Id');
        var date = DateTime.now().toString();

        var data = {
          'version': globals.version,
          'account_Id': account_Id,
          'post_id': widget.id,
          'reply_data': globals.reply_data,
          'reply_date': date,
        };

        var res = await CallApi().postData(data, '(Control)createReply.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == "success") {
          widget.onTap(body[1], date); // get reply id from php body[1]
          //toast success
          //show on forum1
        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          errorPopup(context, globals.error4);
        } else if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        } else {
          globals.loadCreateReplyPage = false;
          errorPopup(context, globals.errorElse);
        }
      } catch (e) {
        print(e);
        globals.loadCreateReplyPage = false;
        errorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }

      globals.loadCreateReplyPage = false;
      print('load createReplyPage end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');
    }
  }

  _onLike() async {
    _loadLike = true;
    while (globals.loadReplyPage == true) {
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
        'post_id': widget.id,
        'like_val': '1',
      };

      var res = await CallApi().postData(data, '(Control)likePosts.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        if (mounted) {
          this.setState(() {
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
            print('sdfashgdgghkasd:  ' + widget.val.toString());
            widget.val = int.parse(body[2]);
            print('sdfashgdgghkasd:  ' + widget.val.toString());
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

      globals.loadLikeDislikeReplyPage = false;
      _loadLike = false;
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
    while (globals.loadReplyPage == true) {
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
        'post_id': widget.id,
        'like_val': '-1',
      };

      var res = await CallApi().postData(data, '(Control)likePosts.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        if (mounted) {
          this.setState(() {
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
            print('sdfashgdgghkasd:  ' + widget.val.toString());
            widget.val = int.parse(body[2]);
            print('sdfashgdgghkasd:  ' + widget.val.toString());
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

  clearTextInput() {
    nameHolder.clear();
  }
}
