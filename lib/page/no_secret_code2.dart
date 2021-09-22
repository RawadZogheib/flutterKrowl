import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Nosecretcode2 extends StatelessWidget {
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
          Text("what university do you go to?",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontFamily: 'Rubik',
                fontSize: 30,
              )),

          Container(
            child: Padding(
              padding:  EdgeInsets.only(left:100.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "start typing your uni name ...",
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
              Navigator.pushNamed(context, '/Uni_has_secret_code');

            },
          ),
        ],
      ),
    );
  }
}
