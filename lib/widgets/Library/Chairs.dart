import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';


class Chair extends StatefulWidget {
  var height;
  var width;
  var color = Colors.blueGrey.shade100;
  var onTap;

  Chair({this.height, this.width,  this.onTap});

  @override
  State<Chair> createState() => _myButtonState();
}

class _myButtonState extends State<Chair> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            widget.color = Colors.red;
          });
          Navigator.pushNamed(context, '/VideoConference');
          widget.onTap();
          },
        child: Stack(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration:
                  BoxDecoration(color: widget.color , shape: BoxShape.circle),
            ),
            Positioned(
              top: 2.5,
              left: 2.5,
              child: Container(
                width: 60,
                height: 60,
                //margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: globals.white, width: 3)),
              ),
            ),
          ],
        ));
  }
}