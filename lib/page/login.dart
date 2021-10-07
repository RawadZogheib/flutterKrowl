import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage('Assets/krowl_logo.png'),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 5.0),
              child: Text("before you get started, we only need your email",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontFamily: 'Rubik',
                    fontSize: 30,
                  )),
            ),
            Container(
              width: 160,
              child: TextField(
                inputFormatters :[
                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                decoration: InputDecoration(
                  hintText: "type your email here ...",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue.shade900.withOpacity(0.5),
                    fontFamily: 'Rubik',
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  globals.emailLogin = value;
                  //print("" + globals.emailLogin);
                },
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
                          if (globals.email != null) {
                            Navigator.pushNamed(context, '/login2');
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Email can not be empty.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
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
