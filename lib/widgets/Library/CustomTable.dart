import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Library/Chairs.dart';
import 'package:flutter_app_backend/widgets/Library/Chairs2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTable extends StatefulWidget {
  var children;
  var roomName;
  var roomType;
  var height;
  var width;
  var color;
  var icon;
  var seats;

  CustomTable({this.children,
    required this.roomName,
    required this.roomType,
    required this.color,
    this.icon,
    this.height,
    this.width,
    this.seats});

  @override
  State<CustomTable> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomTable> {
  List<bool> enablee = [false, false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.shade400,
      child: Stack(
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
                      color: globals.blue1,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.only(top: 90, bottom: 70, right: 70, left: 70),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
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
                Text(widget.roomType + " Room",
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
                          color: widget.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ))
                  ],
                )
              ]),
            ),
          ),
          Positioned(
              top: 65,
              left: 105,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 1),
                angle: 0.0,
              )),
          Positioned(
              top: 65,
              left: 180,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 2),
                angle: 0.0,
              )),
          Positioned(
              top: 140,
              left: 259,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 3),
                angle: -270 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 215,
              left: 259,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 4),
                angle: -270 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 291,
              left: 180,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 5),
                angle: -180 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 291,
              left: 105,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 6),
                angle: -180 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 140,
              left: 34,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 7),
                angle: -90 * 3.14159265359 / 180,
              )),
          Positioned(
              top: 215,
              left: 34,
              child: Chair(
                onTap: () => _sitOnChair(widget.roomName, 8),
                angle: -90 * 3.14159265359 / 180,
              )),
          enablee[0] == true
              ? Positioned(top: 66, left: 105, child: Chair2())
              : Container(),
          enablee[1] == true
              ? Positioned(top: 66, left: 180, child: Chair2())
              : Container(),
          enablee[2] == true
              ? Positioned(top: 127, left: 248, child: Chair2())
              : Container(),
          enablee[3] == true
              ? Positioned(top: 202.5, left: 248, child: Chair2())
              : Container(),
          enablee[4] == true
              ? Positioned(top: 266, left: 180, child: Chair2())
              : Container(),
          enablee[5] == true
              ? Positioned(top: 266, left: 105, child: Chair2())
              : Container(),
          enablee[6] == true
              ? Positioned(top: 127, left: 45, child: Chair2())
              : Container(),
          enablee[7] == true
              ? Positioned(top: 202.5, left: 45, child: Chair2())
              : Container(),
        ],
      ),
    );
  }

  Future<void> _sitOnChair(String roomName, int position) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'roomName': roomName,
      'position': position
    };

    var res = await CallApi().postData(data, '(Control)sitOnChair.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    try {
      localStorage.setString('token', body[1]);
    }catch(e){
      print('no token found');
    }


    if (body[0] == "success") {
      if (!await launch(
        globals.jaasUrl + roomName,
        forceSafariVC: false,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      )) {
        throw 'Could not launch ${globals.jaasUrl + roomName}';
      }
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text("Your version: " + globals.version + "\n" +
                  globals.errorVersion),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  globals.errorToken),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.error7),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else if (body[0] == "error8") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.error8),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
    else if (body[0] == "error9") {
      setState(() {
        enablee[position - 1] = false;
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.error9),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

}