import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter_app_backend/widgets/PreviousButton.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
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
  var blue1;
  var blue2;
  var white;
  @override
  Widget build(BuildContext context) {
    cont = context;
    return Scaffold(
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
                        borderSide: BorderSide(color: Colors.blue.shade900)),
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
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: InkWell(
                      child: PreviousButton(text: "previous",color: blue1, icon: Icons.arrow_back,  onTap: () {
                        Navigator.pop(context, '/login');
                      }, )
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.only(left: 100.sp),
                        child: InkWell(
                          child:NextButton(text: "login",color: blue1, icon: Icons.arrow_forward, onTap: () {
                            if (globals.passwordLogin != null ) {
                              if (globals.passwordLogin!.isNotEmpty)
                                try {
                                  _login();
                                }catch(e){

                                  showDialog<String>(
                                    context: cont,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              globals.errorException),
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
                          }, )
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
    );
  }

  _login()async  {

    if (globals.emailLogin != null
        && globals.passwordLogin != null) {
      if (globals.emailLogin!.isNotEmpty
          && globals.passwordLogin!.isNotEmpty) {

        var data = {
          'version': globals.version,
          'email': globals.emailLogin,
          'password': globals.passwordLogin
        };

        var res = await CallApi().postData(data, '(Control)login.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);
        if (body[0] == "true") {
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.setString('token', body[1]);
          var i=localStorage.getInt("i");
          if(i==1){
            localStorage.setInt("i",2);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Remember Me'),
                  content: const Text(globals.errorRememberMe),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>_yesRemember(),
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => _noRemember(),
                      child: const Text('No'),
                    ),
                  ],
                ),
          );
          }
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
                      globals.error7),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );

        } else if (body[0] == "errorVersion") {
          showDialog<String>(
            context: cont,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(globals.version + "\n"+
                      globals.errorVersion),
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

  _yesRemember() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var e = localStorage.getString("email");
    var p = localStorage.getString("password");

    setState(() {
      print("yessss"+e.toString());
      globals.emailLogin = e;
      globals.passwordLogin = p;
    });


  }


  _noRemember() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("email");
    localStorage.remove("password");
    setState(() {
      globals.emailLogin = "";
      globals.passwordLogin = "";
    });

    Navigator.pushNamed(cont, '/intro_page2');

  }




}
