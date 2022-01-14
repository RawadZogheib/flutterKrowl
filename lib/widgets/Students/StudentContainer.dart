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
    return Column(
      children: [
        Container(

        )
      ],
    );
  }
}
