import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:hovering/hovering.dart';



class Chair extends StatefulWidget {
  var height;
  var width;
  var color = Colors.blueGrey.shade100;
  var onTap;
  var angle;
  Chair({this.height, this.width,required this.angle, this.onTap});

  @override
  State<Chair> createState() => _ChairState();
}

class _ChairState extends State<Chair> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
          angle: widget.angle,
          child:
          InkWell(
            onTap: widget.onTap,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: HoverCrossFadeWidget(
              duration: Duration(milliseconds: 50),
              firstChild: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Assets/clara4.PNG'),
                        fit: BoxFit.cover),)),
              secondChild: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Assets/clara3.png'),
                        fit: BoxFit.cover),)),),
          ),
    );
  }
}
