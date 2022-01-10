import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/Forum/Contributors.dart';
import 'package:flutter_app_backend/widgets/Forum/Forum1/SearchBar.dart';
import 'package:flutter_app_backend/widgets/Forum/ReplyPage/DetailedReplyContainer.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key? key}) : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

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
            DetailedReplyContainer(
                question: "The question will be displayed here",
                subject: "#science",
                username: "Jane Russel",
                contextQuestion:
                    "Contemporary China has recently been seen as in the throes of `neoliberal restructuring'. This claim is contested on theoretical and methodological grounds. During the period of economic liberalization since the death of Mao, China has shown a hybrid governance that has combined earlier Maoist socialist, nationalist and developmentalist practices and discourses of the Communist Party with the more recent market logic of `market socialism'. With that in mind, would you consider China as following the principles of neoliberalism?",
                date: "on Jan25, 2021"),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Contributors(),
              ],
            ),
          ],
        ),
        Text(
          "TESTTTTTTTTT"
        )
      ]),
    );
  }
}
