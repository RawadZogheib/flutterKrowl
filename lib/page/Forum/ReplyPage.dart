import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum2/Contributors.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/DetailedReplyContainer.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/RepliesWidget.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/UnansweredQuestions.dart';
import 'package:flutter_app_backend/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
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
  var children = <Widget>[]; //Replies
  Timer? timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNewPage();
  }

  @override
  Widget build(BuildContext context) {
    var NbrReplies;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailedReplyContainer(
                        id: widget.id,
                        question: widget.question,
                        subject: widget.subject,
                        username: widget.username,
                        contextQuestion: widget.contextQuestion,
                        date: widget.date,
                        onTap: (data) => _addReply(data),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 110.0, bottom: 15),
                        child: Text("Replies ($NbrReplies)",
                            // this is the number of replies
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: children, // My Children
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
                          SizedBox(
                            height: 20,
                          ),
                          UnansweredQuestions(
                            username: 'idotalia',
                            question: ' Anyone here have experience with Pytorch?',
                            contextofquestion: 'dsngujbnuydfvhngysdnbvugfndugn',
                            NbrReplies: 1,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          CustomTabBar(),
        ],
      ),
    );
  }

  _loadReplies() async {
    if (globals.loadReplyPage == false) {
      while (globals.loadLikeDislikeReplyPage == true) {
        await Future.delayed(Duration(seconds: 1));
        print(
            '=========>>======================================================>>==================================================>>=========');
        print("reload replyPage");
        print(
            '=========<<======================================================<<==================================================<<=========');

      }
      try{
      print('load replyPage');
      globals.loadReplyPage = true;

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var account_Id = localStorage.getString("account_Id");

      var data = {
        'version': globals.version,
        'account_Id': account_Id,
        'post_id': widget.id
      };

      var res = await CallApi().postData(data, '(Control)loadReplies.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      children.clear();
      if (body[0] == "success") {
        for (var i = 0; i < body[1].length; i++) {
          Color _color;
          Color _color2;
          if (int.parse(body[1][i][7]) == 0) {
            _color = Colors.grey.shade600;
            _color2 = Colors.grey.shade600;
          } else if (int.parse(body[1][i][7]) == 1) {
            _color = globals.blue1;
            _color2 = Colors.grey.shade600;
          } else if (int.parse(body[1][i][7]) == -1) {
            _color = Colors.grey.shade600;
            _color2 = globals.blue1;
          } else {
            _color = Colors.transparent;
            _color2 = Colors.transparent;
          }
          children.insert(
            0,
            Replies(
              id: body[1][i][0],
              // reply_date
              username: body[1][i][1],
              // username
              reply: body[1][i][2],
              // reply_data
              val: int.parse(body[1][i][3]),
              // reply_like
              date: body[1][0][4],
              // reply_date
              color: _color,
              //
              color2: _color2,
            ),
          );
        }
        if (mounted) {
          setState(() {
            children;
          });
        }
      } else if (body[0] == "errorVersion") {
        ErrorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        ErrorPopup(context, globals.errorToken);
      } else if (body[0] == "error7") {
        WarningPopup(context, globals.warning7);
      } else {
        // if (mounted) {
        //   setState(() {
        //     load = true;
        //   });
        // }
        globals.loadReplyPage = false;
        ErrorPopup(context, globals.errorElse);
      }

      print('load replyPage end!!!');
      print(
          '=========<<======================================================<<==================================================<<=========');

      } catch (e) {
        print(e);
        globals.loadReplyPage = false;
        ErrorPopup(context, globals.errorException);
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    }

    globals.loadReplyPage = false;
  }

  _loadNewPage() {
    print(
        '=========>>======================================================>>==================================================>>=========');
    timer?.cancel();
    _loadReplies(); //0
    _loadPage(); //1 -> INFINI
  }

  _loadPage() {
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      print(
          '=========>>======================================================>>==================================================>>=========');
      print("30sec gone!!");
      if (mounted) {
        print("30sec gone,and _loadChildrenOnline!!");
        _loadReplies();
      } else{
        print(
            '=========<<======================================================<<==================================================<<=========');
      }
    });
  }

  _addReply(data) async {
    print(data);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? username = localStorage.getString('username');
    if (mounted) {
      setState(() {
        children.insert(
          0,
          Replies(
            id: data,
            username: username,
            reply: globals.reply_data,
            val: 0,
            date: DateTime.now().toString(),
            color: Colors.grey.shade600,
            color2: Colors.grey.shade600,
          ),
        );
      });
    }
  }
}
