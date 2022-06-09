import 'dart:convert';

import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';
import 'package:Krowl/widgets/PopUp/Loading/LoadingPopUp.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Login2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  var _email;
  String _password = "";
  var blue1;
  var blue2;
  var white;

  @override
  void initState() {
    // TODO: implement initState
    _getSaved();
    super.initState();
  }

  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    _email = ModalRoute.of(context)!.settings.arguments;
    print('email: $_email');

    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final key = event.logicalKey;
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            //if (_password != null) {
            if (_password.isNotEmpty && _password != ""){
              try {
                _login();
              } catch (e) {
                showDialog<String>(
                  context: context,
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
                      textAlign: TextAlign.center,
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
                      key: Key(_password.toString()),
                      initialValue: _password.toString(),
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
                        _password = value;
                        //print("" + globals.email);
                      },
                      onEditingComplete: () {},
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 111,
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 111,
                            // margin: EdgeInsets.only(left: 100.sp),
                            child: InkWell(
                                child: NextButton(
                                  text: "login",
                                  color: globals.blue1,
                                  icon: Icons.arrow_forward,
                                  onTap: () {
                                    if (_password != null) {
                                      if (_password.isNotEmpty && _password != "")
                                        try {
                                          _login();
                                        } catch (e) {
                                          showDialog<String>(
                                            context: context,
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
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/forgetPass', (route) => false),
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
      var arg = await SessionManager().get("arg");
      //_email = await SessionManager().get("email");
      //_password = await SessionManager().get("password");
      if (_email != null) {
        if (_email.isNotEmpty && _password.isNotEmpty) {
          print("LOGIN2 ARGUMENT = " + arg.toString());
          if (arg != null) {
            if (arg.toString().isNotEmpty) {
              data = {
                'version': globals.version,
                'email': _email,
                'password': _password,
                'private': arg.toString()
              };
            }
          } else {
            data = {
              'version': globals.version,
              'email': _email,
              'password': _password
            };
          }
          var res = await CallApi().postData(data, '(Control)login.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);

          setState(() {
            Navigator.pop(context);
          });

          if (body[0] == "true") {
            //sessionManager.remove("arg");

            print("CHATTTfffffffffffffff: ${body[6]}");
            await SessionManager().set('token', body[1]);
            await SessionManager().set('account_Id', body[2]);
            await SessionManager().set('email', _email.toString());
            await SessionManager().set('username', body[3]);
            await SessionManager().set('user_uni', body[4]);
            await SessionManager().set('photo', body[5]);
            await SessionManager().set('userTokenChat', body[6]);

            if (body[7] == '1') {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
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
            } else if (body[7] == '0') {
              await SessionManager().set('isLoggedIn', false);
              Navigator.pushNamedAndRemoveUntil(
                  context, "/CodeLog", (route) => false);
            } else {
              await SessionManager().set('isLoggedIn', false);
              errorPopup(context, globals.errorElse);
            }
          } else if (body[0] == "errorToken") {
            errorPopup(context, globals.errorToken);
          } else if (body[0] == "errorVersion") {
            errorPopup(context, globals.errorToken);
          } else if (body[0] == "false") {
            warningPopup(context, 'Invalid username or password.');
          } else if (body[0] == "error7") {
            warningPopup(context, globals.warning7);
          } else {
            Navigator.pop(context);
            errorPopup(context, globals.errorElse);
          }
        } else {
          warningPopup(context, globals.warning7);
          Navigator.pop(context);
        }
      } else {
        warningPopup(context, globals.warning7);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      errorPopup(context, globals.errorException);
    }
  }

  _yesRemember() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('email', _email);
    await localStorage.setString('password', _password);
    await SessionManager().set('rememberMe', true);
    await SessionManager().set('isLoggedIn', true);

    // Navigator.popUntil(context, ModalRoute.withName('/intro_page'));
    // Navigator.pushNamed(cont, '/Library');
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }

  _noRemember() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('email');
    await localStorage.remove('password');
    await SessionManager().set('rememberMe', false);
    await SessionManager().set('isLoggedIn', true);
    setState(() {
      _email = "";
      _password = "";
    });

    // Navigator.popUntil(context, ModalRoute.withName('/intro_page'));
    // Navigator.pushNamed(cont, '/Library');
    Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
  }

  _getSaved() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (await localStorage.containsKey('password')) {
      String p = (await localStorage.getString("password")).toString();
      print(p);
      setState(() {
        _password = p;
      });
    }
  }
}
