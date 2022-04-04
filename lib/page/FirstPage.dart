import 'dart:async';
import 'dart:convert';

import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../api/my_api.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
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
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // await localStorage.clear();
    try{
      var sessionManager = SessionManager();
      var arg = await sessionManager.get("arg");
      if(arg != null){
        if (arg.toString().isNotEmpty){
          var data = {
            'version': globals.version,
            'private': arg.toString()
          };

          var res = await CallApi().postData(
              data, '(Control)checkLinkTable.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);
            if (body[0] == 'success') {
              new Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/intro_page', (route) => false);
              });
            }else{
              sessionManager.remove("arg");
              //print("Wrong Link, Please retry again");
              ErrorPopup(context, "Wrong Link, Please retry again");
            }
        }
      }else {
        print("NO ARGUMENT FOR PRIVATE TABLE AVAILABLE");
        new Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/intro_page', (route) => false);
        });
      }
  } catch (e) {
  print(e);
  }
  }
}