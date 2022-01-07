import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Buttons/NextButton.dart';
import 'package:sizer/sizer.dart';

late BuildContext cont;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Code extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    cont = context;
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
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
                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 50,
                            margin: EdgeInsets.only(left: 5),
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code1 = value;
                                //print("" + globals.code1);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code2 = value;
                                //print("" + globals.code2);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code3 = value;
                                //print("" + globals.code3);
                              },
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, bottom: 65.0),
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
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code4 = value;
                                //print("" + globals.code4);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                globals.code5 = value;
                                //print("" + globals.code5);
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            child: TextField(
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade900),
                                    borderRadius: BorderRadius.circular(14)),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                        color: Colors.blue.shade900)),
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                globals.code6 = value;
                                //print("" + globals.code6);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 180.sp),
                    child: NextButton(
                      text: "next",
                      color: blue1,
                      icon: Icons.arrow_forward,
                      onTap: () {
                        _sendCode();
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendCode() async {
    try {
      String? vCode;
      vCode = globals.code1! +
          globals.code2! +
          globals.code3! +
          globals.code4! +
          globals.code5! +
          globals.code6!;
      var data = {
        'version': globals.version,
        'email': globals.email,
        'vCode': vCode
      };
      var res = await CallApi().postData(data, '(Control)getVCode.php');
      List<dynamic> body = json.decode(res.body);
      print(body[0]);
      if (body[0] == "success") {
        Navigator.pushNamedAndRemoveUntil(
            cont, '/intro_page2', (route) => false);
      } else if (body[0] == "errorVersion") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text("Your version: " +
                globals.version +
                "\n" +
                globals.errorVersion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (body[0] == "errorToken") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(globals.errorToken),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (body[0] == "false") {
        showDialog<String>(
          context: cont,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Wrong Code !'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog<String>(
          context: cont,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(globals.errorElse),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog<String>(
        context: cont,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorException),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
