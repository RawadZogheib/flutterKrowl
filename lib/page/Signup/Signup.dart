import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:sizer/sizer.dart';

Color col1 = Colors.blue.shade50;
Color col1_1 = Colors.blue.shade900;
Color col1_2 = Colors.blue.shade900.withOpacity(0.5);
var arg;
RegExp exp = new RegExp(r"[^@\s]+@[^@\s]+");

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Signup extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
     arg= ModalRoute.of(context)!.settings.arguments;
    Size _size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => _back(),
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) async {
          final key = event.logicalKey;
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              try {
                _test1();
              } catch (e) {
                print(e);
                var data = {
                  'exceptionEmail': e.toString(),
                };
                var res = await CallApi()
                    .postData(data, '(Control)exceptionEmail.php');
                print("hjrkehgjjjgggggggggggggggggggg" + res.body);
              }
              ;
            }
            setState(() => keys.add(key));
          } else {
            setState(() => keys.remove(key));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 600,
                    child: TextField(
                      autofocus: true,
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
                        //globals.val = value;
                        //print("" + globals.email);
                      },
                      onEditingComplete: (){},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: PreviousButton(
                          text: "previous",
                          color: Colors.blue.shade900,
                          icon: Icons.arrow_back,
                          onTap: () {
                            globals.email = null;
                            Navigator.pop(context, '/intro_page');
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            margin: EdgeInsets.only(left: 100.sp),
                            child: NextButton(
                              text: "Next",
                              color: Colors.blue.shade900,
                              icon: Icons.arrow_forward,
                              onTap: () async {
                                try {
                                  _test1();
                                } catch (e) {
                                  print(e);
                                  var data = {
                                    'exceptionEmail': e.toString(),
                                  };
                                  var res = await CallApi().postData(
                                      data, '(Control)exceptionEmail.php');
                                  print("hjrkehgjjjgggggggggggggggggggg" +
                                      res.body);
                                }
                                ;
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
          ),
        ),
      ),
    );
  }

  _test1() {
    if (globals.email != null) {
      if (globals.email!.isNotEmpty) {
        if (!globals.email!.contains(" ")) {
          if (exp.hasMatch(globals.email!)) {
            _reg();
            setState(() {
              col1 = Colors.blue.shade50;
              col1_1 = Colors.blue.shade900;
              col1_2 = Colors.blue.shade900.withOpacity(0.5);
            });
          } else {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            WarningPopup(context, globals.warning2_5);
          }
        } else {
          setState(() {
            col1 = Colors.red.shade50;
            col1_1 = Colors.red.shade900;
            col1_2 = Colors.red.shade900.withOpacity(0.5);
          });
          WarningPopup(context, globals.warning1);
        }
      } else {
        setState(() {
          col1 = Colors.red.shade50;
          col1_1 = Colors.red.shade900;
          col1_2 = Colors.red.shade900.withOpacity(0.5);
        });
        WarningPopup(context, globals.warning7);
      }
    } else {
      setState(() {
        col1 = Colors.red.shade50;
        col1_1 = Colors.red.shade900;
        col1_2 = Colors.red.shade900.withOpacity(0.5);
      });
      WarningPopup(context, globals.warning7);
    }
  }

  _reg() async {
    //globals.val2=int.parse(globals.val!);

    globals.photo = "test";
    globals.terms = "test";
    globals.cropX = "test";
    globals.cropY = "test";
    globals.cropWidth = "test";
    globals.cropHeight = "test";

    if (globals.email != null) {
      if (globals.email!.isNotEmpty) {
        if (!globals.email!.contains(" ")) {
          if (exp.hasMatch(globals.email!)) {
            var data = {
              'version': globals.version,
              'email': globals.email,
            };
            var res = await CallApi().postData(data, '(Control)signup.php');
            print(res.body);
            List<dynamic> body = json.decode(res.body);
            if (body[0] == "success") {
              setState(() {
                col1 = Colors.blue.shade50;
                col1_1 = Colors.blue.shade900;
                col1_2 = Colors.blue.shade900.withOpacity(0.5);
              });
              Navigator.pushNamed(context, '/Registration',arguments: arg);
            } else if (body[0] == "errorVersion") {
              ErrorPopup(context, globals.errorVersion);
            } else if (body[0] == "errorToken") {
              ErrorPopup(context, globals.errorToken);
            } else if (body[0] == "error1") {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              WarningPopup(context, globals.warning1);
            } else if (body[0] == "error2_5") {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              WarningPopup(context, globals.warning2_5);
            } else if (body[0] == "error2_6") {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              WarningPopup(context, globals.warning2_6);
            } else if (body[0] == "error6") {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              WarningPopup(context, globals.warning6);
            } else if (body[0] == "error7") {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              WarningPopup(context, globals.warning7);
            } else {
              setState(() {
                col1 = Colors.red.shade50;
                col1_1 = Colors.red.shade900;
                col1_2 = Colors.red.shade900.withOpacity(0.5);
              });
              ErrorPopup(context, globals.errorElse);
            }
          } else {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);
            });
            WarningPopup(context, globals.warning1);
          }
        } else {
          setState(() {
            col1 = Colors.red.shade50;
            col1_1 = Colors.red.shade900;
            col1_2 = Colors.red.shade900.withOpacity(0.5);
          });
          WarningPopup(context, globals.warning2_5);
        }
      } else {
        setState(() {
          col1 = Colors.red.shade50;
          col1_1 = Colors.red.shade900;
          col1_2 = Colors.red.shade900.withOpacity(0.5);
        });
        WarningPopup(context, globals.warning7);
      }
    } else {
      setState(() {
        col1 = Colors.red.shade50;
        col1_1 = Colors.red.shade900;
        col1_2 = Colors.red.shade900.withOpacity(0.5);
      });
      WarningPopup(context, globals.warning7);
    }
  }

  _back() {
    globals.email = null;
    return true;
  }
}
