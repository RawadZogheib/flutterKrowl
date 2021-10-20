
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart';

class SilentTable extends StatefulWidget {
  SilentTable ({ this.children, this.icon,  this.height,  this.width, this.color});
  var children;
  var height;
  var width;
  var color;
  var icon;

  @override
  State<SilentTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<SilentTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blue2,
          borderRadius: BorderRadius.all(Radius.circular(14)),
          border: Border.all(color: blue1, width: 4),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
                "Silent room",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: 'Rubik'
                )),
            Text(
              "0/7",
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
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,))

              ],
            )



          ]
      ),
    );
  }
}