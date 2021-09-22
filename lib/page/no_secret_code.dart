import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Nosecretcode extends StatelessWidget {
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
          Text("what is your email?",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontFamily: 'Rubik',
                fontSize: 30,
              )),

          Padding(
            padding:  EdgeInsets.only(left:100.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "type your email here",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue.shade900.withOpacity(0.5),
                  fontFamily: 'Rubik',
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            child: Container(
              width: 150,
              margin: EdgeInsets.only(left: 100),
              child: Image(
                image: AssetImage('Assets/press_enter.png'),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/no_secret_code2');

            },
          ),
        ],
      ),
    );
  }
}
