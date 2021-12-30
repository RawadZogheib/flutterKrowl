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
      required this.index,
      this.onPressed});

  var index;
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
            color: (globals.selectedPublicPrivet == index) ? globals.blue1 : Colors.grey),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor:
            (globals.selectedPublicPrivet == index) ? globals.blue2 : Colors.grey.shade100,
      ),
    );
  }
}
