import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/myButton.dart';

class QuietTable extends StatefulWidget {
  var children;
  var text;
  var height;
  var width;
  var color;
  var icon;

  QuietTable(
      {this.children,
      required this.text,
      this.icon,
      this.height,
      this.width,
      this.color});

  @override
  State<QuietTable> createState() => _CustomContainerState(
      children: children,
      text: text,
      height: height,
      width: width,
      color: color,
      icon: icon);
}

class _CustomContainerState extends State<QuietTable> {
  var children;
  var text;
  var height;
  var width;
  var color;
  var icon;

  _CustomContainerState(
      {this.children,
      required this.text,
      this.icon,
      this.height,
      this.width,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 5,
          left: 25,
          height: 50,
          width: 250,
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: blue1, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                " - Choose a seat to join",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Positioned(top: 65, left: 100, child: myButton()),
        Positioned(top: 65, left: 180, child: myButton()),
        Positioned(top: 130, left: 245, child: myButton()),
        Positioned(top: 210, left: 245, child: myButton()),
        Positioned(top: 265, left: 180, child: myButton()),
        Positioned(top: 265, left: 100, child: myButton()),
        Positioned(top: 130, left: 45, child: myButton()),
        Positioned(top: 210, left: 45, child: myButton()),
        Container(
          padding: EdgeInsets.only(top: 90, bottom: 70, right: 70,left: 70),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.only(right: 12, left: 1),
            decoration: BoxDecoration(
                color: blue2,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: blue1, width: 4)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Quiet room",
                  style: TextStyle(
                      color: Colors.grey.shade600, fontFamily: 'Rubik')),
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
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Icon(
                      Icons.videocam,
                      color: Colors.grey,
                    ),
                  ),
                  Text(".",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Icon(
                      Icons.mic,
                      color: Colors.grey,
                    ),
                  ),
                  Text(".",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ))
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}
