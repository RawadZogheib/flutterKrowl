import 'dart:ui';
import 'package:desktop_window/desktop_window.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:Krowl/widgets/Buttons/LoginButton.dart';
import 'package:Krowl/widgets/Buttons/SignupButton.dart';

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
    var arg= ModalRoute.of(context)!.settings.arguments;
    Size _size = MediaQuery.of(context).size;

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
                    width: 130,
                    child: YesButton( onTap: () {
                      Navigator.pushNamed(context, '/login',arguments: arg);
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
                      Navigator.pushNamed(context, '/Signup',arguments: arg);
                    },),
                  ),

                ),
              ],
      ),),);

  }

}
