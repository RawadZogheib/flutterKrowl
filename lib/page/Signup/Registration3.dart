import 'dart:convert';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/widgets/Stack.dart';
import 'package:flutter_app_backend/widgets/Buttons/NextButton.dart';
import 'package:flutter_app_backend/widgets/Buttons/PreviousButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color col1 = Colors.blue.shade50;
Color col1_1 = Colors.blue.shade900;
Color col1_2 = Colors.blue.shade900.withOpacity(0.5);

Color col2 = Colors.blue.shade50;
Color col2_1 = Colors.blue.shade900;
Color col2_2 = Colors.blue.shade900.withOpacity(0.5);

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
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, top:100, bottom: 25),
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomStack(text: "Create your krowl account"),
              Column(
                  children: [
              Container(
                width: 470,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade50),
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: col1,
                    hintText: "Password",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: col1_2,
                    ),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: col1_1)),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade50),
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: col2,
                    hintText: "Confirm password",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color:col2_2,
                    ),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: col2_1)),
                  ),
                  onChanged: (value) {
                    globals.repassword = value;
                    //print("" + globals.repassword);
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
              ]),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: PreviousButton(text: "previous", color: blue1, icon: Icons.arrow_back, onTap: () {
                      globals.password = null;
                      globals.repassword = null;
                      Navigator.pop(context, '/Registration2');
                    },)
                  ),
                  Row(
                    children: [
                      Container(
                        width: 98,
                        margin: EdgeInsets.only(left: 100.sp),
                        child: NextButton(text: "signup", color: blue1, icon: Icons. arrow_forward, onTap: () {
                          try {
                            if(_testpass() == true)
                              _reg();
                          } catch (e) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    globals.errorException),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },)
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
_testpass() {
    bool if1= false;
    bool if2= false;
  if (globals.password != null){
    if (globals.password!.isNotEmpty)
        if1=true;
  }
    if (globals.repassword != null){
      if (globals.repassword!.isNotEmpty)
        if2=true;
    }
   if(if1 ==false) {
     setState(() {
       col1 = Colors.red.shade50;
       col1_1 = Colors.red.shade900;
       col1_2 = Colors.red.shade900.withOpacity(0.5);
     });
   }else{
     setState(() {
       col1 = Colors.blue.shade50;
       col1_1 = Colors.blue.shade900;
       col1_2 =
           Colors.blue.shade900.withOpacity(0.5);
     });
   }
     if (if2 == false) {
       setState(() {
         col2 = Colors.red.shade50;
         col2_1 = Colors.red.shade900;
         col2_2 = Colors.red.shade900.withOpacity(0.5);
       });
     }else{
       setState(() {
         col2 = Colors.blue.shade50;
         col2_1 = Colors.blue.shade900;
         col2_2 = Colors.blue.shade900.withOpacity(0.5);
       });
     }

     if (if1 && if2) {
       if (exp.hasMatch(globals.password!)) {

         if (globals.password == globals.repassword) {
           setState(() {
             col1 = Colors.blue.shade50;
             col1_1 = Colors.blue.shade900;
             col1_2 =
                 Colors.blue.shade900.withOpacity(0.5);
           });
           return true;
         } else {
           setState(() {
             col2 = Colors.red.shade50;
             col2_1 = Colors.red.shade900;
             col2_2 = Colors.red.shade900.withOpacity(0.5);
           });
           showDialog<String>(
             context: context,
             builder: (BuildContext context) =>
                 AlertDialog(
                   title: const Text('Error'),
                   content: const Text(
                       globals.error3),
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
                     globals.error2_3),
                 actions: <Widget>[
                   TextButton(
                     onPressed: () => Navigator.pop(context, 'OK'),
                     child: const Text('OK'),
                   ),
                 ],
               ),
         );
       }
     }else {
       showDialog<String>(
         context: context,
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
          !globals.userName!.contains(" ")) {
        //if(exp.hasMatch(globals.password!)) {
        //if (globals.password == globals.repassword) {
        var data = {
          'version': globals.version,
          'email': globals.email,
          'first_name': globals.fName,
          'last_name': globals.lName,
          'username': globals.userName,
          'password': globals.password,
          'repassword': globals.repassword,
          'date_of_birth': globals.dateOfBirth.toString(),
          'photo': globals.photo,
          'terms_of_service': globals.terms,
          'crop_x': globals.cropX,
          'crop_y': globals.cropY,
          'crop_width': globals.cropWidth,
          'crop_height': globals.cropHeight,
          'university_ids': (int.parse(globals.univercitiesName.indexOf(globals.uniId).toString()) + 1).toString(),
          'major_degree_ids': (int.parse(globals.degrees.indexOf(globals.majorId).toString()) + 1).toString(),
          'minor_degree_ids': (int.parse(globals.degrees.indexOf(globals.minorId).toString()) + 1).toString(),
        };
        var res = await CallApi().postData(
            data, '(Control)registration3.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);
        if (body[0] == "success") {
           _saveLogin();
           Navigator.pushNamed(context, '/Code');

        } else if (body[0] == "errorVersion") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text("Your version: " + globals.version + "\n"+
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

        }else if (body[0] == "errorToken") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      globals.errorToken),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        } else if (body[0] == "error1") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(globals.error1),
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
                      globals.error2_1),
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
                      globals.error2_2),
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
                    globals.error2_3),
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
                  content: const Text(globals.error2_4),
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
                  content: const Text(globals.error2_5),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }else if (body[0] == "error2_6") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(globals.error2_6),
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
                      globals.error3),
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
                  content: const Text(globals.error4),
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
                  content: const Text(globals.error5),
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
                  content: const Text(globals.error6),
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
                  content: const Text(globals.error7),
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
                      globals.errorElse),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }
        /* } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error3),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          } */
        /* }else{
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(globals.error2_3,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }  } */
      }else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(globals.error1),
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
          content: const Text(globals.error7),
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
 _saveLogin() async{
    globals.emailLogin = globals.email.toString();
    globals.passwordLogin = globals.password.toString();

  }

  _back() {
    globals.password = null;
    globals.repassword = null;
    return true;
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
