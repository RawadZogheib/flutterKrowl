import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedReplyContainer extends StatefulWidget {
  String id;
  String question;
  String subject;
  String username;
  var date;
  String contextQuestion;
  var onTap;

  DetailedReplyContainer(
      {required this.id,
      required this.question,
      required this.subject,
      required this.username,
      required this.contextQuestion,
      required this.date,
      this.color,
      required this.onTap});

  var color;

  @override
  State<DetailedReplyContainer> createState() => _DetailedReplyContainerState();
}

class _DetailedReplyContainerState extends State<DetailedReplyContainer> {
  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  var color1;

  var color2;

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
                  onTap: () {},
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('1'),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {},
                  child: Icon(
                    Icons.thumb_down,
                    color: Colors.grey,
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
      widget.onTap('33');// get reply id from php body[2]
      //toast success
      //show on forum1
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error7),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
