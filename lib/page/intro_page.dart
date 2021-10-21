import 'dart:ui';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/widgets/YesButton.dart';
import 'package:flutter_app_backend/widgets/NoButton.dart';

var passL;

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));

class Intro extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Intro> createState() => _IntroState();
}


class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    child: YesButton( onTap: () {
                      Navigator.pushNamed(context, '/login');
                    }, ),
                  ),
                ),
                const SizedBox(
                  width: 200,
                  height: 10,
                ),
                InkWell(
                  child: Container(
                    width: 140,
                    padding: EdgeInsets.only(left: 10.0),
                    child: NoButton( onTap: () {
                      Navigator.pushNamed(context, '/Signup');
                    },),
                  ),

                ),
              ],
      ),),);

  }

}
