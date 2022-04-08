import 'dart:async';
import 'dart:convert';

import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../api/my_api.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  bool _threeSecondPassed = false;

  @override
  void initState() {
    _timer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.blue2,
      body: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('Assets/krowl_logo.gif'),
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  _timer() async {
    //await SessionManager().destroy();
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // await localStorage.clear();
    Future.delayed(const Duration(seconds: 3), () {
      _threeSecondPassed = true;
    });
    try {
      var arg = await SessionManager().get("arg");
      if (arg != null) {
        if (arg.toString().isNotEmpty) {
          var data = {'version': globals.version, 'private': arg.toString()};

          var res =
              await CallApi().postData(data, '(Control)checkLinkTable.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);
          if (body[0] == 'success') {
            if (await SessionManager().containsKey("email") &&
                await SessionManager().containsKey("password")) {
              _login();
            } else {
              while (_threeSecondPassed == false) {
                await Future.delayed(Duration(seconds: 1));
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, '/intro_page', (route) => false);
            }
          } else {
            await SessionManager().remove("arg");
            //print("Wrong Link, Please retry again");
            ErrorPopup(context, "Wrong Link, Please retry again");
          }
        }
      } else {
        print("NO ARGUMENT FOR PRIVATE TABLE AVAILABLE");
        if (await SessionManager().containsKey("email") &&
            await SessionManager().containsKey("password")) {
          _login();
        } else {
          while (_threeSecondPassed == false) {
            await Future.delayed(Duration(seconds: 1));
          }
          Navigator.pushNamedAndRemoveUntil(
              context, '/intro_page', (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _login() async {
    var data;
    try {
      var arg = await SessionManager().get("arg");
      String _email = (await SessionManager().get("email")).toString();
      String _password = (await SessionManager().get("password")).toString();
      //_email = await SessionManager().get("email");
      //_password = await SessionManager().get("password");
      if (_email != null && _password != null) {
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

          if (body[0] == "true") {
            //sessionManager.remove("arg");

            print("CHATTTfffffffffffffff: ${body[6]}");
            await SessionManager().set('token', body[1]);
            await SessionManager().set('account_Id', body[2]);
            // await SessionManager().set('email', _email.toString());
            // await SessionManager().set('password', _password!);
            await SessionManager().set('username', body[3]);
            await SessionManager().set('user_uni', body[4]);
            await SessionManager().set('photo', body[5]);
            await SessionManager().set('userTokenChat', body[6]);
            await SessionManager().set('isLoggedIn', true);

            if (body[7] == '1') {
              while (_threeSecondPassed == false) {
                await Future.delayed(Duration(seconds: 1));
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, '/Library', (route) => false);
            } else if (body[7] == '0') {
              while (_threeSecondPassed == false) {
                await Future.delayed(Duration(seconds: 1));
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, "/Code", (route) => false);
            } else {
              while (_threeSecondPassed == false) {
                ;
                await Future.delayed(Duration(seconds: 1));
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, '/intro_page', (route) => false);
              ErrorPopup(context, globals.errorElse);
            }
          } else if (body[0] == "errorToken") {
            while (_threeSecondPassed == false) {
              await Future.delayed(Duration(seconds: 1));
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro_page', (route) => false);
            ErrorPopup(context, globals.errorToken);
          } else if (body[0] == "errorVersion") {
            while (_threeSecondPassed == false) {
              await Future.delayed(Duration(seconds: 1));
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro_page', (route) => false);
            ErrorPopup(context, globals.errorToken);
          } else if (body[0] == "false") {
            while (_threeSecondPassed == false) {
              await Future.delayed(Duration(seconds: 1));
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro_page', (route) => false);
            WarningPopup(context, 'Invalid username or password.');
          } else if (body[0] == "error7") {
            while (_threeSecondPassed == false) {
              await Future.delayed(Duration(seconds: 1));
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro_page', (route) => false);
            WarningPopup(context, globals.warning7);
          } else {
            while (_threeSecondPassed == false) {
              await Future.delayed(Duration(seconds: 1));
            }
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro_page', (route) => false);
            ErrorPopup(context, globals.errorElse);
          }
        } else {
          while (_threeSecondPassed == false) {
            await Future.delayed(Duration(seconds: 1));
          }
          Navigator.pushNamedAndRemoveUntil(
              context, '/intro_page', (route) => false);
          WarningPopup(context, globals.warning7);
        }
      } else {
        while (_threeSecondPassed == false) {
          await Future.delayed(Duration(seconds: 1));
        }
        Navigator.pushNamedAndRemoveUntil(
            context, '/intro_page', (route) => false);
        WarningPopup(context, globals.warning7);
      }
    } catch (e) {
      print(e);
      while (_threeSecondPassed == false) {
        await Future.delayed(Duration(seconds: 1));
      }
      Navigator.pushNamedAndRemoveUntil(
          context, '/intro_page', (route) => false);
      ErrorPopup(context, globals.errorException);
    }
  }
}
