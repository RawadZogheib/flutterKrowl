import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:sizer/sizer.dart';

String ddd = 'sss';

Color col1 = Colors.blue.shade50;
Color col1_1 = Colors.blue.shade900;
Color col1_2 = Colors.blue.shade900.withOpacity(0.5);

Color col2 = Colors.blue.shade50;
Color col2_1 = Colors.blue.shade900;
Color col2_2 = Colors.blue.shade900.withOpacity(0.5);

Color col3 = Colors.blue.shade50;
Color col3_1 = Colors.blue.shade900;
Color col3_2 = Colors.blue.shade900.withOpacity(0.5);

Color col4 = Colors.blue.shade50;
Color col4_1 = Colors.blue.shade900;
Color col4_2 = Colors.blue.shade900.withOpacity(0.5);



void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Registration extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            children: <Widget>[
              Container(
                child: (Image(
                  image: AssetImage('Assets/Register.png'),
                )),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: 250,
                height: 130,
                child: (Text(
                  'Create your krowl account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'Rubik',
                    fontSize: 35,
                  ),
                )),
              ),
            ],
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: col1,
                hintText: "First name",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: col1_2,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: col1_1)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                globals.fName = value;
                //print("" + globals.fName);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: col2,
                hintText: "Last name",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: col2_2,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: col2_1)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                globals.lName = value;
                //print("" + globals.lName);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor:col3,
                hintText: "Username",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: col3_2,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: col3_1)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                globals.userName = value;
                //print("" + globals.userName);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: col4,
                hintText: "Age",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: col4_2,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: col4_1)),
              ),
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                globals.dateOfBirth = value;
                //print("" + globals.dateOfBirth);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      Text("previous",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontFamily: 'Rubik',
                            fontSize: 20,
                          )),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context, '/intro_page2');
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 100.sp),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("next",
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontFamily: 'Rubik',
                                fontSize: 20,
                              )),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 25,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {

                        bool if1 = false;
                        bool if2 = false;
                        bool if3 = false;
                        bool if4 = false;

                        if (globals.fName != null)
                          if(globals.fName!.isNotEmpty)
                            if1=true;

                        if(globals.lName != null)
                          if(globals.lName!.isNotEmpty)
                            if2=true;

                        if(globals.userName != null)
                          if(globals.userName!.isNotEmpty)
                            if3=true;

                        if(globals.dateOfBirth != null)
                          if(globals.dateOfBirth!.isNotEmpty)
                            if4=true;

                        if(if1){
                          setState(() {
                            col1 = Colors.blue.shade50;
                            col1_1 = Colors.blue.shade900;
                            col1_2 = Colors.blue.shade900.withOpacity(0.5);
                          });
                        }else{
                          setState(() {
                            col1 = Colors.red.shade50;
                            col1_1 = Colors.red.shade900;
                            col1_2 = Colors.red.shade900.withOpacity(0.5);
                          });
                        }

                        if(if2){
                          setState(() {
                            col2 = Colors.blue.shade50;
                            col2_1 = Colors.blue.shade900;
                            col2_2 = Colors.blue.shade900.withOpacity(0.5);
                          });
                        }else{
                          setState(() {
                            col2 = Colors.red.shade50;
                            col2_1 = Colors.red.shade900;
                            col2_2 = Colors.red.shade900.withOpacity(0.5);
                          });
                        }


                        if(if3){
                          setState(() {
                            col3 = Colors.blue.shade50;
                            col3_1 = Colors.blue.shade900;
                            col3_2 = Colors.blue.shade900.withOpacity(0.5);
                          });
                        }else{
                          setState(() {
                            col3 = Colors.red.shade50;
                            col3_1 = Colors.red.shade900;
                            col3_2 = Colors.red.shade900.withOpacity(0.5);
                          });
                        }


                        if(if4){
                          setState(() {
                            col4 = Colors.blue.shade50;
                            col4_1 = Colors.blue.shade900;
                            col4_2 = Colors.blue.shade900.withOpacity(0.5);
                          });
                        }else{
                          setState(() {
                            col4 = Colors.red.shade50;
                            col4_1 = Colors.red.shade900;
                            col4_2 = Colors.red.shade900.withOpacity(0.5);
                          });
                        }

                        if(if1==true && if2==true && if3==true && if4==true){
                          Navigator.pushNamed(context, '/Registration2');
                        }else{
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text("Fields can't be Empty."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
