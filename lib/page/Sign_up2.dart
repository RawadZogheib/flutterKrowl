import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Signup2 extends StatelessWidget {
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
            margin: EdgeInsets.only(left: 15),
            child: Text("check your email for a 6-digit code",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontFamily: 'Rubik',
                  fontSize: 30,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Row(
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
                    ),
                  ),
                ),

              ],
            ),
          ),

          InkWell(
            child:

            Container(
              width: 150,
              margin: EdgeInsets.only(left: 190),
              child: Image(image:
              AssetImage('Assets/press_enter.png'),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/intro_page2');
            },),



        ],
      ),
    );
  }
}
