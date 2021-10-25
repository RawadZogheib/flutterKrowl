import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:sizer/sizer.dart';

class QuietTable extends StatefulWidget {
  QuietTable({ this.children, this.icon,  this.height,  this.width, this.color});
  var children;
  var height;
  var width;
  var color;
  var icon;

  @override
  State<QuietTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<QuietTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(70),
        decoration: BoxDecoration(
        border: Border.all(
        color: Colors.grey.shade400,
        width: 1,
    ),
          borderRadius: BorderRadius.circular(5),),
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.only(right: 12, left: 1),
        decoration: BoxDecoration(
            color: blue2,
          borderRadius: BorderRadius.all(Radius.circular(14)),
            border: Border.all(color: blue1, width:4)
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
            "Quiet room",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontFamily: 'Rubik'
            )),
            Text(
              "0/8",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontFamily: 'Rubik',
                fontSize: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.videocam,
                  color: Colors.grey,
                ),
                    Text(".",
                        style: TextStyle(
                            color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,)),
                    Icon( Icons.mic,
                      color: Colors.grey,
                    ),
                    Text(".",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,))

              ],
            )



          ]
        ),
      ),
    );
  }
}