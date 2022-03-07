import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

class TableButton extends StatelessWidget {
  String text;
  final onTap;

  TableButton(
      {required this.text,
      this.color,
      this.onTap,
      required this.isSilent,
      this.onPressed});

  bool isSilent;
  var setState;
  var color;
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            fontFamily: 'Rubik',
            color: (globals.isSilent == isSilent) ? globals.blue1 : Colors.grey),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor:
            (globals.isSilent == isSilent) ? globals.blue2 : Colors.grey.shade100,
      ),
    );
  }
}

class TableButton2 extends StatelessWidget {
  String text;
  final onTap;

  TableButton2(
      {required this.text,
        this.color,
        this.onTap,
        required this.isPrivet,
        this.onPressed});

  bool isPrivet;
  var setState;
  var color;
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            fontFamily: 'Rubik',
            color: (globals.isPrivet == isPrivet) ? globals.blue1 : Colors.grey),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor:
        (globals.isPrivet == isPrivet) ? globals.blue2 : Colors.grey.shade100,
      ),
    );
  }
}
