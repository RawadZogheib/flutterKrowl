import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

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
              height: 50,
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
            InkWell(
              child: Container(
                child: Text(
                  "test",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              onTap: () async {

                SharedPreferences localStorage = await SharedPreferences.getInstance();

                var data = {
                'user_id': 69
                };

                var res = await CallApi().postData(data, 'test3_2.php');
                print(res.body);
                List<dynamic> body = json.decode(res.body);
                if (body[0].toString() == "truee") {
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  localStorage.setString('token', body[1]);
                  print(body[1]);
                }

              },
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
                          child: NextButton(
                        text: "next",
                        color: Colors.white,
                        icon: Icons.arrow_forward,
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/intro_page', (route) => false);
                        },
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
