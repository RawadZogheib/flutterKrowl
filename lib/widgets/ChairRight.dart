import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chair2 extends StatefulWidget {
  Chair2({ this.icon,  this.height,  this.width, this.color});
  var height;
  var width;
  var color;
  var icon;

  @override
  State<Chair2> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<Chair2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(150),
            topRight: Radius.circular(150)),
        color: Colors.blueGrey.shade100,
        shape: BoxShape.rectangle,
      ),
      height: 35,
      width: 55,
    );

  }
}