import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/widgets/Stack.dart';

RegExp exp = new RegExp(r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@#$%^&:,?_-]).{8,}$");


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Registration3 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Registration3> createState() => _Registration3State();
}

class _Registration3State extends State<Registration3> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomStack(text: "Create your krowl account"),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                globals.password = value;
                //print("" + globals.password);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Confirm password",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
              onChanged: (value) {
                globals.repassword = value;
                //print("" + globals.repassword);
              },
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(
            height: 20,
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
                    Navigator.pop(context, '/Registration2');
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 98,
                    margin: EdgeInsets.only(left: 100.sp),
                    child: InkWell(
                      child: Row(
                        children: [
                          Text("Sign up",
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
                        try {
                          _reg();
                        } catch (e) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'OOPs! Something went wrong. Try again in few seconds.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
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
        ]),
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

    if (globals.email != null &&
        globals.fName != null &&
        globals.lName != null &&
        globals.userName != null &&
        globals.password != null &&
        globals.repassword != null &&
        globals.dateOfBirth != null &&
        globals.photo != null &&
        globals.terms != null &&
        globals.cropX != null &&
        globals.cropY != null &&
        globals.cropWidth != null &&
        globals.cropHeight != null &&
        globals.uniId != null &&
        globals.majorId != null &&
        globals.minorId != null) {
      if (!globals.email!.contains(" ") &&
          !globals.userName!.contains(" ") &&
          !globals.password!.contains(" ") &&
          !globals.repassword!.contains(" ")) {
        if(exp.hasMatch(globals.password!)) {
          if (globals.password == globals.repassword) {
            var data = {
              'email': globals.email,
              'first_name': globals.fName,
              'last_name': globals.lName,
              'username': globals.userName,
              'password': globals.password,
              'repassword': globals.repassword,
              'date_of_birth': globals.dateOfBirth,
              'photo': globals.photo,
              'terms_of_service': globals.terms,
              'crop_x': globals.cropX,
              'crop_y': globals.cropY,
              'crop_width': globals.cropWidth,
              'crop_height': globals.cropHeight,
              'university_ids': globals.uniId,
              'major_degree_ids': globals.majorId,
              'minor_degree_ids': globals.minorId,
            };
            var res = await CallApi().postData(
                data, '(Control)registration3.php');
            print(res.body);
            List<dynamic> body = json.decode(res.body);
            if (body[0] == "success") {
              Navigator.pushNamed(context, '/Code');
            } else if (body[0] == "error1") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No Spaces Allowed.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error2_1") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Your username must contain at least 8 characters.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error2_2") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Your username can only contain lowercase and uppercase characters and special characters( _ .).'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error2_3") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Your password must contain at least 8 characters, 1 lowercase(a-z),1 uppercase(A-Z),1 numeric character(0-9) and 1 special character(!,\$,#,@,%).'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error2_4") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Your age must be greater than 17.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error2_5") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('It\'s not a university email.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error3") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Please make sure your passwords match.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error4") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Error with registration.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error5") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('UserName already exist.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error6") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Email already exist.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else if (body[0] == "error7") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Connection error.'),
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
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Failed to connect... Connection Problem.'),
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
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'Please make sure your passwords match.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
        }else{
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Your password must contain at least 8 characters, 1 lowercase(a-z),1 uppercase(A-Z),1 numeric character(0-9) and 1 special character(* . ! @ # \$ % ^ & : , ? _ -).'),
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
            content: const Text('No Spaces Allowed.'),
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
          content: const Text('No nulls Allowed.'),
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
/*
var res = await CallApi().postData(data, '(Control)regist.php');
print(res.body);
List<dynamic> body = json.decode(res.body);
print("asdasdsadsad");
print("asdasdsadsad");
print(body[0]);
//print(body['stts']);
//if(body['success']){
if(body[0] == "success"){
Navigator.pushNamed(cont, '/Code');
//SharedPreferences localStorage = await SharedPreferences.getInstance();
// localStorage.setString('token', body['token']);
//localStorage.setString('user', json.encode(body['user']));
}*/
