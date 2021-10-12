
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  var text;

  CustomStack ({   this.children, required this.text});
    var children;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: (Image(
            image: AssetImage('Assets/Register.png'),
          )),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          width: 250,
          height: 130,
          child: (Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
              fontFamily: 'Rubik',
              fontSize: 35,
            ),
          )),
        ),
      ],
    );
  }
}