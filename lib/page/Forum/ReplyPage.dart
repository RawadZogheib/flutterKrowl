import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum2/Contributors.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/DetailedReplyContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/RepliesWidget.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/UnansweredQuestions.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyPage extends StatefulWidget {
  String id;
  String question;
  String subject;
  String username;
  String contextQuestion;
  var date;

  ReplyPage(
      {required this.id,
        required this.question,
        required this.subject,
        required this.username,
        required this.contextQuestion,
        required this.date});

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  var children3 = <Widget>[]; //Replies
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadReplies();
  }
  @override
  Widget build(BuildContext context) {
    var NbrReplies;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

            children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTabBar(),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailedReplyContainer(
                      id:widget.id,
                      question: widget.question,
                      subject: widget.subject,
                      username: widget.username,
                      contextQuestion:widget.contextQuestion,
                      date: widget.date),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 110.0, bottom: 15),
                    child: Text(
                        "Replies ($NbrReplies)", // this is the number of replies
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)
                    ),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: children3, // My Children
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Contributors(),
                      SizedBox(height: 20,),
                      UnansweredQuestions(username: 'idotalia', question:' Anyone here have experience with Pytorch?', contextofquestion: 'dsngujbnuydfvhngysdnbvugfndugn', NbrReplies: 1,)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
  _loadReplies() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var account_Id = localStorage.getString("account_Id");


    var data = {
      'version': globals.version,
      'account_Id': account_Id,
      'post_id':widget.id
    };

    var res = await CallApi().postData(data, '(Control)loadReplies.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    if (body[0] == "success") {
      for (var i = 0; i < body[1].length; i++) {
        children3.addAll(
          [
            Replies(
              id: body[1][i][0],
              // reply_date
              username: body[1][i][1],
              // username
              reply: body[1][i][2],
              // reply_data
              NbrReplies:int.parse(body[1][i][3]),
              // reply_like
              date: body[1][0][4],
              // reply_date
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      }
      setState(() {
        children3;
      });
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
