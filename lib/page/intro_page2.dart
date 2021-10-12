
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:sizer/sizer.dart';
void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro2()));

class Intro2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: EdgeInsets.only(left: 100.sp),
                      child: InkWell(
                        child: NextButton(text: "next", icon: Icons.arrow_forward, onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/intro_page', (route) => false);
                        },)

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
