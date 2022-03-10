import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart'  as globals;

class MyButton extends StatelessWidget {
  final onTap;

  MyButton({required this.icon, required this.onTap });
  var icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
           decoration: BoxDecoration(
                color: globals.blue2,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: globals.blue1, width: 4)),
            child: Center(
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
