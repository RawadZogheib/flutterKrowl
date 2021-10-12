import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter_app_backend/widgets/PreviousButton.dart';
import 'package:sizer/sizer.dart';

Color col1 = Colors.blue.shade50;
Color col1_1 = Colors.blue.shade900;
Color col1_2 = Colors.blue.shade900.withOpacity(0.5);

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Signup extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
            Text("what is your email?",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: 'Rubik',
                  fontSize: 30,
                )),
            Container(
              width: 600,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade50),
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: col1,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: col1_1)),
                  hintText: "type your email here...",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: col1_2,
                    fontFamily: 'Rubik',
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  globals.email = value;
                  //print("" + globals.email);
                },
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
                    child: PreviousButton(text: "previous", icon: Icons.arrow_back,  onTap: () {
                      globals.email = null;
                      Navigator.pop(context, '/intro_page');
                    },)
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: EdgeInsets.only(left: 100.sp),
                      child: InkWell(
                        child: NextButton(text: "Next", icon: Icons.arrow_forward, onTap: (){ _reg(); },),

                       /*   if (globals.email != null) {
                            if (globals.email!.isNotEmpty) {
                              if (!globals.email!.contains(" ")) {

                                setState(() {
                                  col1 = Colors.blue.shade50;
                                  col1_1 = Colors.blue.shade900;
                                  col1_2 = Colors.blue.shade900.withOpacity(0.5);
                                });
                                Navigator.pushNamed(context, '/Registration');
                              }else {
                                setState(() {
                                  col1 = Colors.red.shade50;
                                  col1_1 = Colors.red.shade900;
                                  col1_2 = Colors.red.shade900.withOpacity(0.5);
                                });
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text('No spaces Allowed .'),
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
                            } else {
                              setState(() {
                                col1 = Colors.red.shade50;
                                col1_1 = Colors.red.shade900;
                                col1_2 = Colors.red.shade900.withOpacity(0.5);
                              });
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Email can not be empty.'),
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
                          } else {
                            setState(() {
                              col1 = Colors.red.shade50;
                              col1_1 = Colors.red.shade900;
                              col1_2 = Colors.red.shade900.withOpacity(0.5);
                            });
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Email can not be null.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }*/



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

  _reg() async {
    globals.photo = "test";
    globals.terms = "test";
    globals.cropX = "test";
    globals.cropY = "test";
    globals.cropWidth = "test";
    globals.cropHeight = "test";

    if (globals.email != null) {
      if (globals.email!.isNotEmpty) {
        if (!globals.email!.contains(" ")) {

          var data = {
            'email': globals.email,
          };
          var res = await CallApi().postData(
              data, '(Control)signup.php');
          print("ujhruirrrrrrrrrrrrrrrrrrrrrrr"+res.body);
          List<dynamic> body = json.decode(res.body);
          if (body[0] == "success") {
            setState(() {
              col1 = Colors.blue.shade50;
              col1_1 = Colors.blue.shade900;
              col1_2 =
                  Colors.blue.shade900.withOpacity(0.5);
            });
            Navigator.pushNamed(context, '/Registration');
          } else if (body[0] == "error1") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'No Spaces Allowed.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error2_5") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'It\'s not a university email.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error2_6") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        ' It\'s not an  email format.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error6") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'Email already exist.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          } else if (body[0] == "error7") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'Connection error.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'Failed to connect... Connection Problem.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
        } else {
          setState(() {
            col1 = Colors.red.shade50;
            col1_1 = Colors.red.shade900;
            col1_2 =
                Colors.red.shade900.withOpacity(0.5);
          });
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'No spaces Allowed .'),
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
      } else {
        setState(() {
          col1 = Colors.red.shade50;
          col1_1 = Colors.red.shade900;
          col1_2 = Colors.red.shade900.withOpacity(0.5);
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content:
            const Text('Email can not be empty.'),
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
    } else {
      setState(() {
        col1 = Colors.red.shade50;
        col1_1 = Colors.red.shade900;
        col1_2 = Colors.red.shade900.withOpacity(0.5);
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Email can not be null.'),
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

