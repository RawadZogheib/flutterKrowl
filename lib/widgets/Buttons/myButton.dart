import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;

class btn extends StatelessWidget {
  var btnText;
  var onTap;

  btn({required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(btnText),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: Colors.blue.shade200,
        ),);
  }
}

class myButton extends StatelessWidget {
  var btnText;
  var height;
  var width;
  var onPress;

  myButton({required this.btnText, this.height, this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: globals.blue,
        onPrimary: globals.blue_1,
        shadowColor: Colors.transparent,
        fixedSize:
            Size(width != null ? width : 50, height != null ? height : 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(btnText),
      onPressed: () {
        onPress();
        //print("Submitted2");
      },
    );
  }
}



class myBtn extends StatelessWidget {
  var btnText;
  double? height;
  double? width;
  var onPress;

  myBtn({required this.btnText, this.height, this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        height: this.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: globals.blue,
            onPrimary: globals.blue_1,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Text(btnText),
          onPressed: () {
            onPress();
            //print("Submitted2");
          },
        ),
    );
  }
}





class myBtn2 extends StatelessWidget {
  var btnText;
  double? height;
  double? width;
  var onPress;
  var color1,color2;

  myBtn2({this.btnText, this.height, this.width, this.onPress, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color1,
          onPrimary: color2,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: btnText,
        onPressed: () {
          onPress();
          //print("Submitted2");
        },
      ),
    );
  }
}