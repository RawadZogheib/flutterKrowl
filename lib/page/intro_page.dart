import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));

class Intro extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        margin: EdgeInsets.all(25.0.sp),
        alignment: Alignment.center,
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Studying. But better.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 72,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 200,
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Yes",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 30,
                            )),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 33.0),
                            child: Icon(
                              Icons.arrow_right_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Sign_up');
                  },
                ),
                const SizedBox(
                  width: 200,
                  height: 10,
                ),
                InkWell(
                  child: Container(
                    width: 140,
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 30,
                            )),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: Icon(
                              Icons.arrow_right_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/no_secret_code');
                  },
                ),
              ],
      ),),);

  }
}
