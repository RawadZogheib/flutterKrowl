import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Library/Chairs.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTable extends StatefulWidget {
  var children;
  var roomName;
  var roomType;
  var height;
  var width;
  var color;
  var color2;
  var icon;

  CustomTable(
      {this.children,
        required this.roomName,
        required this.roomType,
        required this.color2,
        this.icon,
        this.height,
        this.width,
        this.color
      });

  @override
  State<CustomTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomTable> {

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
                widget.roomName,
                style: TextStyle(
                    color: globals.blue1, fontSize: 15, fontWeight: FontWeight.bold),
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
                color: globals.blue2,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: globals.blue1, width: 4)),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(widget.roomType,
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
                        color: widget.color2,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ))
                ],
              )
            ]),
          ),
        ),
        Positioned(top: 66, left: 105, child: Chair(onTap: () => _createRoom(widget.roomName), angle: -0 * 3.14159265359 / 180,)),
        Positioned(top: 66, left: 180, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -0 * 3.14159265359 / 180,)),
        Positioned(top: 140, left: 259, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -270 * 3.14159265359 / 180,)),
        Positioned(top: 215, left: 259, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -270 * 3.14159265359 / 180,)),
        Positioned(top: 291, left: 180, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -180 * 3.14159265359 / 180,)),
        Positioned(top: 291, left: 105 , child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -180 * 3.14159265359 / 180,)),
        Positioned(top: 140, left: 34, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -90 * 3.14159265359 / 180,)),
        Positioned(top: 215, left: 34, child: Chair(onTap: () => _createRoom(widget.roomName),  angle: -90 * 3.14159265359 / 180,)),

      ],
    );
  }

  Future<void> _createRoom(String url) async {
    if (!await launch(
      globals.jaasUrl + url,
      forceSafariVC: false,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch ${globals.jaasUrl + url}';
    }
  }
}
