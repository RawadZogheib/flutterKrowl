import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Forum/Forum1/AskQuestionButton.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:google_fonts/google_fonts.dart';


class Replies extends StatelessWidget {
  String id;
  String username;
  String reply;
  var date;

  Replies({ required this.reply, this.NbrReplies, required this.username, required this.date,required this.id,this.color,});
  var color;
  var NbrReplies;
  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 660,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30, right: 15),
                      child: Text(
                        reply,// this is the reply answer
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
          ),
        ],
      );
  }
}
