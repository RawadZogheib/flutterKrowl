import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chair4 extends StatefulWidget {
  Chair4({ this.icon,  this.height,  this.width, this.color});
  var height;
  var width;
  var color;
  var icon;

  @override
  State<Chair4> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<Chair4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(150),
            bottomLeft: Radius.circular(150)),
        color: Colors.blueGrey.shade100,
        shape: BoxShape.rectangle,
      ),
      height: 35,
      width: 55,
    );

  }
}