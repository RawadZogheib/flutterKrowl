import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YesButton extends StatelessWidget {
  var text;
  final onTap;

  YesButton({ this.text, this.color = Colors.white, this.icon, required this.onTap });
  final Color color;
  var icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Yes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 30,
              )),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 33.0),
              child: Icon(
                Icons.arrow_right_alt,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),);
  }
}
