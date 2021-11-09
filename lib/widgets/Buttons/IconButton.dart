import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart'  as globals;

class myButton extends StatelessWidget {
  final onTap;

  myButton({ this.color = Colors.white, required this.icon, required this.onTap });
  final Color color;
  var icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: globals.blue2,
           decoration: BoxDecoration(
                color: globals.blue2,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: globals.blue1, width: 4)),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                icon,
                size: 40,
                color: globals.blue1 ,
              ),
            ),
          ),
        ],
      ),);
  }
}
