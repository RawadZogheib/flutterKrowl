import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/RepliesWidget.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/UnansweredQuestions.dart';

import 'Responsive.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Test()));

class Test extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        UnansweredQuestions(username: 'idotalia', question:' Anyone here have experience with Pytorch?', contextofquestion: 'dsngujbnuydfvhngysdnbvugfndugn', NbrReplies: 1,),
        Replies( date: "posted on Jan 25, 2021", username: 'DimitriHaddad', reply: 'Yes', NbrReplies: 1, id: '1',),
      ]),
    );
  }

}



