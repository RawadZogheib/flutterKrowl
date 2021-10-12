import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  var text;
  final onTap;

  NextButton({ required this.text, this.color, required this.icon, this.onTap });
  var color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text (text,
            style: TextStyle(fontSize: 20, fontFamily: 'Rubik', color: Colors.blue.shade900),

            ),
          Icon(this.icon,
            color: Colors.blue.shade900,
            size: 25,
          ),
      ]
    ),);
  }
}
