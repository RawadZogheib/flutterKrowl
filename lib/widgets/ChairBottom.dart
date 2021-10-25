import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chair3 extends StatefulWidget {
  Chair3({ this.icon,  this.height,  this.width, this.color});
  var height;
  var width;
  var color;
  var icon;

  @override
  State<Chair3> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<Chair3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(150),
            bottomRight: Radius.circular(150)),
        color: Colors.blueGrey.shade100,
        shape: BoxShape.rectangle,
      ),
      height: 35,
      width: 55,
    );

  }
}