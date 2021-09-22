import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Hassecretcode2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('Assets/krowl_logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text("great new! your uni has a secret code!",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: 'Rubik',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: 50,
          ),

          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text("look around your campus or ask your friends for the code ... unfortunately we can’t let you in without the code",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: 'Rubik',
                  fontSize: 30,
                )),
          ),
          SizedBox(
            height: 80,
          )

        ],
      ),
    );
  }
}
