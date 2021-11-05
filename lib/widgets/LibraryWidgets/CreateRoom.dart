import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Dropdown.dart';
import 'package:flutter_app_backend/widgets/Buttons/RadioButton.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;


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
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),),
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
                child: TextButton(
                  child: Text( 'Create Room',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: globals.white,fontSize: 20, fontFamily: 'Rubik'),
                  ),
                  onPressed: () {},
                  style: TextButton.styleFrom(backgroundColor: globals.blue1),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
