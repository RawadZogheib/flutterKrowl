import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;


class StudentButton extends StatelessWidget {
  var text;
  var fontSize;
  // double width;
  double height;
  final onPressed;

  StudentButton({ required this.text,required this.fontSize, required this.height, required this.textcolor, required this.color1,required this.color2, this.color, required this.onPressed});
  var color;
  var color1;
  var color2;
  var textcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ElevatedButton(onPressed: onPressed,
        style:
        ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color1),
            shadowColor: MaterialStateProperty.all<Color>(color2),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    side: BorderSide(color: globals.blue2)
                )
            )
        ),
        child: Text (text,
          style: TextStyle(fontSize: fontSize, fontFamily: 'Rubik', color: textcolor),

        ),),
    );
  }
}