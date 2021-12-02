import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;


class AskQuestionButton extends StatelessWidget {
  var text;
  final onPressed;

  AskQuestionButton({ this.text, this.color, this.onPressed});
  var color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 40,
      child: ElevatedButton(onPressed: (){
        Navigator.pushNamed(context, '/Code');
      },
        style:
        ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(globals.blue2),
            shadowColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: globals.blue2)
                )
            )
        ),
        child: Text ('Ask a question',
        style: TextStyle(fontSize: 17, fontFamily: 'Rubik', color: globals.blue1),

      ),),
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