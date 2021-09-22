import 'dart:ui';

import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro2()));

class Intro2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        children: [
          const SizedBox(
            width: 200,
            height: 200,
          ),
          Column(
            children: [
              Text(
                'all done :)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Rubik',
                  fontSize: 72,
                ),
              ),
              const SizedBox(
                width: 200,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
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

              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("enter your uni space",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 20,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                },
              ),

            ],
          ),
        ],
      ),
    );
  }
}
