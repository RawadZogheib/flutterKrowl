import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Forum/ReplyPage.dart';
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  var height;
  var width;
  String id;
  String username;
  String tag;
  String text;
  String question_context;

  bool like;
  bool dislike;

  int val;
  var date;
  var color = Colors.grey.shade600;
  var color2 = Colors.grey.shade600;
  var onTap;

  Question(
      {this.height,
      this.width,
      required this.id,
      required this.username,
      required this.tag,
      required this.text,
      required this.val,
      required this.date,
      required this.like,
      required this.dislike,
      required this.question_context,
      this.onTap});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.like == false && widget.dislike == false) {
      //0
      widget.color = Colors.grey.shade600;
      widget.color2 = Colors.grey.shade600;
    } else if (widget.like == true && widget.dislike == false) {
      //1
      widget.color = globals.blue1;
      widget.color2 = Colors.grey.shade600;
    } else if (widget.like == false && widget.dislike == true) {
      //-1
      widget.color = Colors.grey.shade600;
      widget.color2 = globals.blue1;
    }
  }

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
                        if (globals.load == false) {
                          globals.load = true;
                          await _onLike();
                          globals.load = false;
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
                        if (globals.load == false) {
                          globals.load = true;
                          await _onDislike();
                          globals.load = false;
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

  _onLike() {
    if (widget.like == false) {
      if (widget.dislike == false) {
        setState(() {
          widget.val += 1;
          widget.like = true;
          widget.color = globals.blue1;
          widget.color2 = Colors.grey.shade600;
        });
      } else {
        setState(() {
          widget.val += 2;
          widget.like = true;
          widget.dislike = false;
          widget.color = globals.blue1;
          widget.color2 = Colors.grey.shade600;
        });
      }
    } else {
      setState(() {
        widget.val -= 1;
        widget.like = false;
        widget.color = Colors.grey.shade600;
        widget.color2 = Colors.grey.shade600;
      });
    }
  }

  _onDislike() {
    if (widget.dislike == false) {
      if (widget.like == false) {
        setState(() {
          widget.val -= 1;
          widget.dislike = true;
          widget.color = Colors.grey.shade600;
          widget.color2 = globals.blue1;
        });
      } else {
        setState(() {
          widget.val -= 2;
          widget.dislike = true;
          widget.like = false;
          widget.color = Colors.grey.shade600;
          widget.color2 = globals.blue1;
        });
      }
    } else {
      setState(() {
        widget.val += 1;
        widget.dislike = false;
        widget.color = Colors.grey.shade600;
        widget.color2 = Colors.grey.shade600;
      });
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
              contextQuestion: widget.question_context,
              date: widget.date),
        ),
        (route) => false);
  }
}
