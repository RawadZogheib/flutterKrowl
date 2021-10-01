
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro2()));

class Intro2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height:50,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'all done :)',
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
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              alignment: Alignment.center,
              child: Text(
                'Welcome to Krowl',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Rubik',
                  fontSize: 72,
                ),
              ),
            ),

            SizedBox(
              height: 100,
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
                          margin: EdgeInsets.only(left: 10.sp),
                          child: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text("previous",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 20,
                            )),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context, '/intro_page');
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
                            Text("enter your uni space",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Rubik',
                                  fontSize: 20,
                                )),
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/Registration');
                        },
                      ),
                    ),
                  ],
                ),


              ],),
          ],
        ),
      ),
    );
  }
}
