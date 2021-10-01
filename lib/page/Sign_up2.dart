import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Signup2 extends StatelessWidget {
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
            Container(
              margin: EdgeInsets.only(left: 10.sp),
              child: Text("check your email for a 6-digit code",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Rubik',
                    fontSize: 30,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 50,
                    margin: EdgeInsets.only(left: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),

                  Container(
                    height: 100,
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),

                  Container(
                    height: 100,
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),


                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left:5, bottom: 65.0),
                      child: Icon(
                        Icons.minimize,
                        size: 40,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),


                  Container(
                    height: 100,
                    width: 50,
                    margin: EdgeInsets.only(left: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),

                  Container(
                    height: 100,
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),

                  Container(
                    height: 100,
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(14)),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                    ),
                  ),

                ],
              ),
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
                      Navigator.pop(context, '/Sign_up');
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
                              width: 30,
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
                          Navigator.pushNamed(context, '/intro_page2');
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
