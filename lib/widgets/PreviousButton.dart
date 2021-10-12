import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  var text;
  var onTap;

  PreviousButton ({ this.onTap, required this.text, this.color = Colors.white, required this.icon });
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(this.icon,
              color: color,
              size: 25,
            ),
            Text (text,
              style: TextStyle(fontSize: 20, fontFamily: 'Rubik', color: color),

            ),
          ]
      ),);
  }
}
