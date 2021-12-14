

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';

class TableButton extends StatelessWidget {
  String text;
  final onTap;

  TableButton({ required this.text, this.color, this.onTap, required this.index,  this.onPressed});
  int index;
  var setState;
  var color;
  var onPressed;
  int selected = 0;
  @override
  Widget build(BuildContext context) {

    return OutlinedButton(
      onPressed: () {
    setState(() {
        selected = index;
      });
    } ,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontFamily: 'Rubik', color: blue1
        ),
      ),
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
      ),
    );
  }
}

