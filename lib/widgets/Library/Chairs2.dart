import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:hovering/hovering.dart';


class Chair2 extends StatefulWidget {
  var height;
  var width;
  var color = Colors.blueGrey.shade100;
  var onTap;
  String img = 'Assets/testNet.PNG';
  Chair2({this.height, this.width, this.onTap});

  @override
  State<Chair2> createState() => _Chair2State();
}

class _Chair2State extends State<Chair2> {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.img),
                fit: BoxFit.cover),));
  }
}
