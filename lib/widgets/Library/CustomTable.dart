import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Library/Chairs.dart';
import 'package:flutter_app_backend/widgets/Library/Chairs2.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTable extends StatefulWidget {
  var children;
  var table_name;
  var table_type;
  var height;
  var width;
  var color;

  var icon;
  var seats;
  var id;
  bool hiddenBool = true;
  bool status = false;
  List<bool> enablee = [false, false, false, false, false, false, false, false];
  List<String> imgs = ['', '', '', '', '', '', '', ''];


  CustomTable(
      {this.children,
      required this.table_name,
      required this.table_type,
      required this.color,
      this.id,
      this.icon,
      this.height,
      this.width,
      this.seats});

  @override
  State<CustomTable> createState() => _CustomContainerState();

}

class _CustomContainerState extends State<CustomTable>
    with TickerProviderStateMixin {





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
                widget.table_name,
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
              Text(widget.table_type + " Table",
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
              onTap: () => _sitOnChair(widget.table_name, 1),
              angle: 0.0,
            )),
        Positioned(
            top: 65,
            left: 180,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 2),
              angle: 0.0,
            )),
        Positioned(
            top: 140,
            left: 259,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 3),
              angle: -270 * 3.14159265359 / 180,
            )),
        Positioned(
            top: 215,
            left: 259,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 4),
              angle: -270 * 3.14159265359 / 180,
            )),
        Positioned(
            top: 291,
            left: 180,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 5),
              angle: -180 * 3.14159265359 / 180,
            )),
        Positioned(
            top: 291,
            left: 105,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 6),
              angle: -180 * 3.14159265359 / 180,
            )),
        Positioned(
            top: 140,
            left: 34,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 7),
              angle: -90 * 3.14159265359 / 180,
            )),
        Positioned(
            top: 215,
            left: 34,
            child: Chair(
              onTap: () => _sitOnChair(widget.table_name, 8),
              angle: -90 * 3.14159265359 / 180,
            )),
        widget.enablee[0] == true
            ? Positioned(top: 66, left: 105, child: Chair2(img: widget.imgs[0].toString()))
            : Container(),
        widget.enablee[1] == true
            ? Positioned(top: 66, left: 180, child: Chair2(img: widget.imgs[1].toString()))
            : Container(),
        widget.enablee[2] == true
            ? Positioned(top: 127, left: 248, child: Chair2(img: widget.imgs[2].toString()))
            : Container(),
        widget.enablee[3] == true
            ? Positioned(top: 202.5, left: 248, child: Chair2(img: widget.imgs[3].toString()))
            : Container(),
        widget.enablee[4] == true
            ? Positioned(top: 266, left: 180, child: Chair2(img: widget.imgs[4].toString()))
            : Container(),
        widget.enablee[5] == true
            ? Positioned(top: 266, left: 105, child: Chair2(img: widget.imgs[5].toString()))
            : Container(),
        widget.enablee[6] == true
            ? Positioned(top: 202.5, left: 45, child: Chair2(img: widget.imgs[7].toString()))
            : Container(),
        widget.enablee[7] == true
            ? Positioned(top: 127, left: 45, child: Chair2(img: widget.imgs[6].toString()))
            : Container(),
        hiddenFunction(),
        Positioned(
          top: 15,
          right: 20,
          child: FlutterSwitch(
            width: 60,
            height: 27,
            valueFontSize: 25.0,
            toggleSize: 25.0,
            value: widget.status,
            borderRadius: 30.0,
            padding: 0.0,
            activeColor: globals.blue1,
            inactiveColor: globals.blue2,
            activeToggleColor: globals.blue1,
            inactiveToggleColor: globals.blue2,
            activeIcon: Icon(
              Icons.lightbulb,
              color: Colors.yellow,
            ),
            inactiveIcon: Icon(
              Icons.lightbulb_outline_sharp,
              color: Colors.white,
            ),
            onToggle: (val) {

              toggleButton(val);
            },
          ),
        ),
      ],
    );
  }


  Future<void> _sitOnChair(String table_name, int position) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'table_name': table_name,
      'position': position
    };

    var res = await CallApi().postData(data, '(Control)sitOnChair.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
      setState(() {
        widget.enablee[position - 1] = true;
      });
      if (!await launch(
        globals.jaasUrl + table_name,
        forceSafariVC: false,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      )) {
        throw 'Could not launch ${globals.jaasUrl + table_name}';
      }
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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
        builder: (BuildContext context) => AlertDialog(
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
    } else if (body[0] == "error9") {
      setState(() {
        widget.enablee[position - 1] = true;
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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

  hiddenFunction() {
    if (widget.hiddenBool == true) {
      return Container(
        height: 360,
        width: 340,
        color: Colors.black.withOpacity(0.3),
      );
    } else {
      return Container();
    }
  }

toggleButton(bool val) async {
    setState(() {
      widget.status = val;
    });
    if (widget.status == true) {
      widget.hiddenBool = false;
      setState(() {
        loadOccupants();
        if (globals.tmpid != null) {
           print(globals.children[globals.tmpid].status.toString());
          globals.children[globals.tmpid].status = false;
           print(globals.children[globals.tmpid].status.toString());
          globals.children[globals.tmpid].hiddenBool = true;
          globals.tmpid = widget.id;
          print("if: " + globals.tmpid.toString());
        } else {
          globals.tmpid = widget.id;
          print("else: " + globals.tmpid.toString());
        }
      });
      await Future.delayed(const Duration(minutes: 2), () {
        setState(() {
          widget.status = false;
          widget.hiddenBool = true;

          globals.tmpid = null;
          widget.enablee = [false, false, false, false, false, false, false, false];

        });
      });
    } else {
      setState(() {
        globals.tmpid = null;
        widget.hiddenBool = true;
        widget.enablee = [false, false, false, false, false, false, false, false];
      });
    }
  }

  loadOccupants() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      var data = {
        'version': globals.version,
        'table_name': widget.table_name,
      };

      var res = await CallApi().postData(data, '(Control)loadOccupants.php');
      print(res.body);
      List<dynamic> body = json.decode(res.body);
      // try {
      //   localStorage.setString('token', body[1]);
      // } catch (e) {
      //   print('no token found');
      // }

      if (body[0] == "success") {
        for (var i = 0; i < body[2].length; i++) {
          await Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              widget.imgs[int.parse(body[2][i][2].toString()) - 1] = '';
              widget.enablee[int.parse(body[2][i][2].toString()) - 1] = true;
            });
          });

        }
      } else if (body[0] == "errorVersion") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                "Your version: " + globals.version + "\n" + globals.errorVersion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (body[0] == "errorToken") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(globals.errorToken),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (body[0] == "error4") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
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
      }else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(globals.errorElse),
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
