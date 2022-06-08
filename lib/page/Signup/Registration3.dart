import 'dart:convert';
//import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/globals/globals.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:Krowl/widgets/Stack.dart';
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';

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
  List<LogicalKeyboardKey> keys = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _back(),
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event){
          final key = event.logicalKey;
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              try {
                if(_testpass() == true)
                  _reg();
              } catch (e) {
                errorPopup(context, globals.errorException);
              }
            }
            setState(() => keys.add(key));
          }
          else{
            setState(() => keys.remove(key));
          }
        },
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
                    autofocus: true,
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
                    onEditingComplete: (){},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 470,
                  child: TextField(
                    autofocus: true,
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
                    onEditingComplete: (){},
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
                              errorPopup(context, globals.errorException);
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
           warningPopup(context, globals.error3);
         }
       } else {
         setState(() {
           col1 = Colors.red.shade50;
           col1_1 = Colors.red.shade900;
           col1_2 = Colors.red.shade900.withOpacity(0.5);
         });
         warningPopup(context, globals.warning2_3);
       }
     }else {
       warningPopup(context, globals.warning7);
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
          'university_ids': (globals.univercitiesName.indexOf(globals.uniId) + 1).toString(),
          'major_degree_ids': (globals.degrees.indexOf(globals.majorId) + 1).toString(),
          'minor_degree_ids': (globals.degrees.indexOf(globals.minorId) + 1).toString(),
          'isRegistered': globals.isRegistered,
        };

        // print('version: '+ globals.version);
        // print('email: '+ globals.email.toString());
        // print('first_name: '+ globals.fName.toString());
        // print('last_name: '+ globals.lName.toString());
        // print('username: '+ globals.userName.toString());
        // print('password: '+ globals.password.toString());
        // print('repassword: '+ globals.repassword.toString());
        // print('date_of_birth: '+ globals.dateOfBirth.toString());
        // print('photo: '+ globals.photo.toString());
        // print('terms_of_service: '+ globals.terms.toString());
        // print('crop_x: '+ globals.cropX.toString()) ;
        // print('crop_y: '+ globals.cropY.toString());
        // print('crop_width: '+ globals.cropWidth.toString());
        // print('crop_height: '+ globals.cropHeight.toString());
        // print('university_ids: '+ globals.univercitiesName.indexOf(globals.uniId).toString());
        // print('major_degree_ids: '+ globals.degrees.indexOf(globals.majorId).toString());
        // print('minor_degree_ids: '+ globals.degrees.indexOf(globals.minorId).toString());
        
        var res = await CallApi().postData(
            data, '(Control)registration3.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);
        if (body[0] == "true") {
           //_saveLogin();
           Navigator.pushNamed(context, '/CodeReg');

        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "error1") {
          warningPopup(context, globals.warning1);
        } else if (body[0] == "error2_1") {
          warningPopup(context, globals.warning2_1);
        } else if (body[0] == "error2_2") {
          warningPopup(context, globals.warning2_2);
        } else if (body[0] == "error2_3") {
          warningPopup(context, globals.warning2_3);
        } else if (body[0] == "error2_4") {
          warningPopup(context, globals.warning2_4);
        } else if (body[0] == "error2_5") {
          warningPopup(context, globals.warning2_5);
        }else if (body[0] == "error2_6") {
          warningPopup(context, globals.warning2_6);
        } else if (body[0] == "error3") {
          errorPopup(context, globals.error3);
        } else if (body[0] == "error4") {
          errorPopup(context, globals.error4);
        } else if (body[0] == "error5") {
          warningPopup(context, globals.warning5);
        } else if (body[0] == "error6") {
          warningPopup(context, globals.warning6);
        } else if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        } else {
          errorPopup(context, globals.errorElse);
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
        warningPopup(context, globals.warning1);
      }
    } else {
      warningPopup(context, globals.warning7);
    }
  }
 // _saveLogin() async{
 //   // globals.emailLogin = globals.email.toString();
 //   // globals.passwordLogin = globals.password.toString();
 //
 //   await SessionManager().set("email",globals.email!);
 //   await SessionManager().set("username",globals.userName!);
 //   await SessionManager().set("password",globals.password!);
 //
 //  }

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
