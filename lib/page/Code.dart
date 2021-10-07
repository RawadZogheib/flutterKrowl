import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

late BuildContext cont;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Code extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    cont = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.code1 = value;
                        //print("" + globals.code1);
                      },
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
                      ),textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.code2 = value;
                        //print("" + globals.code2);
                      },
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.code3 = value;
                        //print("" + globals.code3);
                      },
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.code4 = value;
                        //print("" + globals.code4);
                      },
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.code5 = value;
                        //print("" + globals.code5);
                      },
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
                      textInputAction: TextInputAction.done,
                      onChanged: (value){
                        globals.code6 = value;
                        //print("" + globals.code6);
                      },
                    ),
                  ),

                ],
              ),
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

                          _reg();

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

    _reg() async {

    String? vCode;
    vCode = globals.code1! + globals.code2! + globals.code3! +
        globals.code4! + globals.code5! + globals.code6!;
      var data = {
        'email'  : globals.email,
        'vCode'  : vCode
      };
      var res = await CallApi().postData(data, '(Control)getVCode.php');
      List<dynamic> body = json.decode(res.body);
      print(body[0]);
      if(body[0] == "success"){
        Navigator.pushNamed(cont, '/intro_page2');
    }else{
        showDialog<String>(
          context: cont,
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
  }
}
