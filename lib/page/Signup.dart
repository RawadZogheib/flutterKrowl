import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Signup extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
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

            Container(
              width: 160,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "type your email here...",
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
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Text("previous",
                            style: TextStyle(
                              color: Colors.blue.shade900,
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
                            Text("next",
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontFamily: 'Rubik',
                                  fontSize: 20,
                                )),
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/Signup2');
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
