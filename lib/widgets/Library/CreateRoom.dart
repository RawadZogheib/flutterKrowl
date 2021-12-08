import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/widgets/Dropdown.dart';
import 'package:flutter_app_backend/widgets/Buttons/RadioButton.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class CreateRoom extends StatefulWidget {


 CreateRoom ({ this.children, });
  var children;
  @override
  State<CreateRoom> createState() => _NextButtonState();
}

class _NextButtonState extends State<CreateRoom> {

  String? dropdownValue;
  List gender = [
    '4',
    '5',
    '6',
    '7',
    '8'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 250,
          height: 415,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 65,),
                  Text("Create a Room",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Rubik', color:Colors.black),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text("Room Name *",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontFamily: 'Rubik', color:Colors.black),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                  width: 220,
                  height:40,
                  child: TextInput1()),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text("Number of Seats *",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontFamily: 'Rubik', color:Colors.black),),
                ],
              ),
              SizedBox(height: 10,),
              Dropdown1(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width:88,child: RoomButton(text: "Quiet", index: 1)),
                  SizedBox(width: 35,),
                  Container(width:95,child: RoomButton(text: "Silent", index: 2))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoomButton(text: "Public", index: 3),
                  SizedBox(width: 35,),
                  RoomButton(text: "Private", index: 4)
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: 220,
                height: 40,
                child: ElevatedButton(onPressed: (){
                  _createRoom();
                },
                  style:
                  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(globals.blue1),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: globals.blue1)
                          )
                      )
                  ),
                  child: Text ('Create room',
                    style: TextStyle(fontSize: 17, fontFamily: 'Rubik', color: globals.white),

                  ),),
              ),
            ],
          ),
        ),
      ],
    );

  }


  Future<void> _createRoom() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'roomName': TextInput1(),
      'seats': Dropdown1(),
      'private':'0'
    };

    var res = await CallApi().postData(data, '(Control)sitOnChair.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

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
    } else if (body[0] == "error10") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.error10),
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
