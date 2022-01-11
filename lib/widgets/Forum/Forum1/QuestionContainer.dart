import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  var height;
  var width;
  String id;
  String username;
  String tag;
  String text;
  int val;
  DateTime date;
  var color = Colors.grey.shade600;
  var color2 = Colors.grey.shade600;
  var onTap;

  Question({this.height,
    this.width,
    required this.id,
    required this.username,
    required this.tag,
    required this.text,
    required this.val,
    required this.date,
    this.onTap});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool _like = false;
  bool _dislike = false;

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
            width: MediaQuery.of(context).size.width*0.62,
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
                      width: MediaQuery.of(context).size.width*0.35,
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
                            backgroundImage: AssetImage("Assets/userImage1.jpeg"),
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
                      onTap: () {
                        _onLike();
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
                      onTap: () {
                        _onDislike();
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
    if (_like == false) {
      if (_dislike == false) {
        setState(() {
          widget.val += 1;
          _like = true;
          widget.color = globals.blue1;
          widget.color2 = Colors.grey.shade600;
        });
      } else {
        setState(() {
          widget.val += 2;
          _like = true;
          _dislike = false;
          widget.color = globals.blue1;
          widget.color2 = Colors.grey.shade600;
        });
      }
    } else {
      setState(() {
        widget.val -= 1;
        _like = false;
        widget.color = Colors.grey.shade600;
        widget.color2 = Colors.grey.shade600;
      });
    }
  }

  _onDislike() {
    if (_dislike == false) {
      if (_like == false) {
        setState(() {
          widget.val -= 1;
          _dislike = true;
          widget.color = Colors.grey.shade600;
          widget.color2 = globals.blue1;
        });
      } else {
        setState(() {
          widget.val -= 2;
          _dislike = true;
          _like = false;
          widget.color = Colors.grey.shade600;
          widget.color2 = globals.blue1;
        });
      }
    } else {
      setState(() {
        widget.val += 1;
        _dislike = false;
        widget.color = Colors.grey.shade600;
        widget.color2 = Colors.grey.shade600;
      });
    }
  }

  _openReply() {
    print('go to reply');
    Navigator.pushNamed(context, '/ReplyPage');
  }
}