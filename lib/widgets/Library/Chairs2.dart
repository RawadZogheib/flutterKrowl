import 'package:flutter/material.dart';

class Chair2 extends StatefulWidget {
  var height;
  var width;
  var color = Colors.blueGrey.shade100;
  var onTap;
  String img;

  Chair2({this.height, this.width, this.onTap, required this.img});

  @override
  State<Chair2> createState() => _Chair2State();
}

class _Chair2State extends State<Chair2> {
  @override
  Widget build(BuildContext context) {
    // if(widget.img.isEmpty){
    //   widget.img = 'Assets/testNet.PNG';
    // }

    return widget.img.isEmpty
        ? Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Assets/testNet.PNG'), fit: BoxFit.cover),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              width: 50,
              height: 50,
              child: Image.network(widget.img),
            ),
          );
  }
}
