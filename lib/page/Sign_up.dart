import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Signup extends StatelessWidget {
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
            margin: EdgeInsets.only(left: 30),
            child: Text("before you get started, we only need your email",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: 'Rubik',
                  fontSize: 30,
                )),
          ),

          Container(
            child: Padding(
              padding:  EdgeInsets.only(left:100.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "type your email here ...",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue.shade900.withOpacity(0.5),
                    fontFamily: 'Rubik',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),


          InkWell(
            child: Container(
              width: 150,
              margin: EdgeInsets.only(left: 190),
              child: Image(
                image: AssetImage('Assets/press_enter.png'),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Sign_up2');
            },
          ),
        ],
      ),
    );
  }
}
