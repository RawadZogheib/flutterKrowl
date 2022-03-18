import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';
import 'package:Krowl/widgets/PopUp/Loading/LoadingPopUp.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

late BuildContext cont;
var arg;
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Login2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  var blue1;
  var blue2;
  var white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSaved();
  }

  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    arg= ModalRoute.of(context)!.settings.arguments;
    cont = context;
    Size _size = MediaQuery.of(context).size;

    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final key = event.logicalKey;
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            if (globals.passwordLogin != null) {
              if (globals.passwordLogin!.isNotEmpty)
                try {
                  _login();
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
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Password can not be empty.'),
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
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text("What is your password ?",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontFamily: 'Rubik',
                        fontSize: 30,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 600,
                    child: TextFormField(
                      autofocus: true,
                      key: Key(globals.passwordLogin.toString()),
                      initialValue: globals.passwordLogin.toString(),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade50),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.blue.shade50,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue.shade900)),
                        hintText: "type your password here...",
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue.shade900,
                          fontFamily: 'Rubik',
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        globals.passwordLogin = value;
                        //print("" + globals.email);
                      },
                      onEditingComplete: (){
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: InkWell(
                          child: PreviousButton(
                        text: "previous",
                        color: globals.blue1,
                        icon: Icons.arrow_back,
                        onTap: () {
                          Navigator.pop(context, '/login');
                        },
                      )),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          margin: EdgeInsets.only(left: 100.sp),
                          child: InkWell(
                              child: NextButton(
                            text: "login",
                            color: globals.blue1,
                            icon: Icons.arrow_forward,
                            onTap: () {
                              if (globals.passwordLogin != null) {
                                if (globals.passwordLogin!.isNotEmpty)
                                  try {
                                    _login();
                                  } catch (e) {
                                    showDialog<String>(
                                      context: cont,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Error'),
                                        content:
                                            const Text(globals.errorException),
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
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Password can not be empty.'),
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
                          )),
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
    );
  }

  _login() async {
    var data;
    LoadingPopUp(context);
    try {
      if (globals.emailLogin != null && globals.passwordLogin != null) {
        if (globals.emailLogin!.isNotEmpty &&
            globals.passwordLogin!.isNotEmpty) {
          if(arg != null){
            if(arg.toString().isNotEmpty){
               data = {
                'version': globals.version,
                'email': globals.emailLogin,
                'password': globals.passwordLogin,
                'private':arg
              };
            }
          }else{
            data = {
              'version': globals.version,
              'email': globals.emailLogin,
              'password': globals.passwordLogin
            };
          }
          var res = await CallApi().postData(data, '(Control)login.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);

          setState(() {
            Navigator.pop(context);
          });

          if (body[0] == "true") {
            SharedPreferences localStorage =
            await SharedPreferences.getInstance();
            // print("fffffffffffffff: ${body[1]}");
            // print("fffffffffffffff: ${body[2]}");
            // print("fffffffffffffff: ${body[3]}");
            // print("fffffffffffffff: ${body[4]}");
            print("CHATTTfffffffffffffff: ${body[6]}");
            localStorage.setString('token', body[1]);
            localStorage.setString('account_Id', body[2]);
            localStorage.setString('username', body[3]);
            localStorage.setString('user_uni', body[4]);
            localStorage.setString('photo', body[5]);
            localStorage.setString('userTokenChat', body[6]);

            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Remember Me'),
                    content: const Text(globals.rememberMe),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => _yesRemember(),
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => _noRemember(),
                        child: const Text('No'),
                      ),
                    ],
                  ),
            );
          } else if (body[0] == "errorToken") {
            ErrorPopup(context, globals.errorToken);
          } else if (body[0] == "errorVersion") {
            ErrorPopup(context, globals.errorToken);
          } else if (body[0] == "false") {
            WarningPopup(context, 'Invalid username or password.');
          } else if (body[0] == "error7") {
            WarningPopup(context, globals.warning7);
          } else {
            Navigator.pop(context);
            ErrorPopup(context, globals.errorElse);
          }
        } else {
          WarningPopup(context, globals.warning7);
        }
      } else {
        WarningPopup(context, globals.warning7);
      }

    }catch(e){
      print(e);
      Navigator.pop(context);
      ErrorPopup(context, globals.errorException);
    }
  }

  _yesRemember() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('email', globals.emailLogin!);
    localStorage.setString('password', globals.passwordLogin!);

    // Navigator.popUntil(context, ModalRoute.withName('/intro_page'));
    // Navigator.pushNamed(cont, '/Library');
    Navigator.pushNamedAndRemoveUntil(
        context, '/Library', (route) => false);
  }

  _noRemember() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("email");
    localStorage.remove("password");
    setState(() {
      globals.emailLogin = "";
      globals.passwordLogin = "";
    });

    // Navigator.popUntil(context, ModalRoute.withName('/intro_page'));
    // Navigator.pushNamed(cont, '/Library');
    Navigator.pushNamedAndRemoveUntil(
        context, '/Library', (route) => false);
  }

  _getSaved() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var p = localStorage.getString("password");
    print(p);

    if (p != null) {
      setState(() {
        globals.passwordLogin = p;
      });
    }
  }
}
