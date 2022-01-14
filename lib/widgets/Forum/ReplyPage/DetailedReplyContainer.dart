import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';


class DetailedReplyContainer extends StatelessWidget {
  String question;
  String subject;
  String username;
  var date;
  String contextQuestion;

  DetailedReplyContainer({ required this.question, required this.subject, required this.username, required this.contextQuestion,  required this.date,this.color});
  var color;
  var color1;
  var color2;
  @override
  Widget build(BuildContext context) {
    return
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 110.0, bottom: 15),
              child: Text(
                question, // this is the question
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
              child: Text(subject, //this is the subject of the quest
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
                    username, //this is the username
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Rubik'),
                  ),
                ),
                Text(
                  date, //this is the date
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
                      padding: const EdgeInsets.only( left: 45, bottom: 30, right: 15),
                      child: Text(
                        contextQuestion,
                        style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w600),
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
                      onTap: () {
                      },
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
                      onTap: () {
                      },
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
                        fillColor: Colors.white,
                        focusColor: Colors.transparent,
                        cursorColor: Colors.transparent,
                        hintText: 'Type here to reply to $username ',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 50),
              child: Container(
                  width:120,
                  child: AskQuestionButton(text: 'Reply', textcolor: globals.blue1, color1: globals.blue2, color2: Colors.grey, onPressed: () {})),
            )
          ],
        );
  }
}
