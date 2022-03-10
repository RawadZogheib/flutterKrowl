import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

class AskQuestionButton extends StatelessWidget {
  var text;
  var onPressed;

  AskQuestionButton(
      {required this.text,
      required this.textcolor,
      required this.color1,
      required this.color2,
      this.color,
      required this.onPressed});

  var color;
  var color1;
  var color2;
  var textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color1),
            shadowColor: MaterialStateProperty.all<Color>(color2),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: globals.blue2)))),
        child: Text(
          text,
          style: TextStyle(fontSize: 17, fontFamily: 'Rubik', color: textcolor),
        ),
      ),
    );
  }
}
/*Container(
width: 170,
height: 40,
decoration: BoxDecoration(
color: globals.blue2,
borderRadius: BorderRadius.circular(6),
),
child: InkWell(
onTap: onTap,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text ('Ask a question',
style: TextStyle(fontSize: 17, fontFamily: 'Rubik', color: globals.blue1),

),
]
),),
);*/
