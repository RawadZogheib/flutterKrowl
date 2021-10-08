import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:sizer/sizer.dart';

late BuildContext cont;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Login2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    cont = context;
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
              child: Text("What is your password ?",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontFamily: 'Rubik',
                    fontSize: 30,
                  )),
            ),
            Container(
              width: 250,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "type your password here ...",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue.shade900.withOpacity(0.5),
                    fontFamily: 'Rubik',
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  globals.emailPassword = value;
                  //print("" + globals.emailPassword);
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
                      Navigator.pop(context, '/login');
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
                            Text("login",
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
                          if (globals.emailPassword != null ) {
                            if (globals.emailPassword!.isNotEmpty)
                              try {
                                _login();
                              }catch(e){

                                showDialog<String>(
                                  context: cont,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'OOPs! Something went wrong. Try again in few seconds.'),
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
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Password can not be empty.'),
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

  _login()async  {

    if (globals.emailLogin != null
        && globals.emailPassword != null) {
      if (globals.emailLogin!.isNotEmpty
          && globals.emailPassword!.isNotEmpty) {

        var data = {
          'email': globals.emailLogin,
          'password': globals.emailPassword
        };

        var res = await CallApi().postData(data, '(Control)login.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);
        if (body[0] == "true") {
          Navigator.pushNamed(cont, '/intro_page2');
        } else if (body[0] == "false") {
          showDialog<String>(
            context: cont,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'Invalid username or password.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        } else if (body[0] == "error7") {
          showDialog<String>(
            context: cont,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'Connection error.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        } else {
          showDialog<String>(
            context: cont,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'Failed to connect... Try again in few seconds.'),
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
          context: cont,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'No empty Allowed.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),);
      }

    } else {

      showDialog<String>(
        context: cont,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'No nulls Allowed.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),);
    }



  }
}
