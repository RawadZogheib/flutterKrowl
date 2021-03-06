import 'package:flutter/material.dart';

class NoButton extends StatelessWidget {
  var text;
  final onTap;

  NoButton ({ this.text, this.color = Colors.white, this.icon, required this.onTap });
  final Color color;
  var icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Signup",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 25,
              )),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 12.0),
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
