import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Stack.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Registration2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Registration2> createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomStack(text: "Create your krowl account"),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Find your university",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value){
                globals.uniId = value;
                //print("" + globals.uniId);
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
                fillColor: Colors.blue.shade50,
                hintText: "Find your major(s)",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value){
                globals.majorId = value;
                //print("" + globals.minorId);
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
                fillColor: Colors.blue.shade50,
                hintText: "Find your minor(s)",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
              textInputAction: TextInputAction.done,
              onChanged: (value){
                globals.minorId = value;
                //print("" + globals.minorId);
              },
            ),
          ),
          SizedBox(
            height: 130,
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
                    Navigator.pop(context, '/Registration');
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
                      onTap: () {if (globals.uniId != null && globals.majorId != null && globals.minorId != null) {
                        Navigator.pushNamed(context, '/Registration3');
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Those fields can not be empty.'),
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


            ],),
        ]),
      ),
    );
  }
}
