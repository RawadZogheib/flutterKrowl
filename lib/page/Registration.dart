import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter_app_backend/widgets/PreviousButton.dart';
import 'package:flutter_app_backend/widgets/Stack.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

String ddd = 'sss';


Color col1 = Colors.blue.shade50;
Color col1_1 = Colors.blue.shade900;
Color col1_2 = Colors.blue.shade900.withOpacity(0.5);

Color col2 = Colors.blue.shade50;
Color col2_1 = Colors.blue.shade900;
Color col2_2 = Colors.blue.shade900.withOpacity(0.5);

Color col3 = Colors.blue.shade50;
Color col3_1 = Colors.blue.shade900;
Color col3_2 = Colors.blue.shade900.withOpacity(0.5);

Color col4 = Colors.blue.shade50;
Color col4_1 = Colors.blue.shade900;
Color col4_2 = Colors.blue.shade900.withOpacity(0.5);

RegExp exp = new RegExp(r"^[a-zA-Z0-9_\.]*$", caseSensitive: false);

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    ));

class Registration extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = new TextEditingController();

  var myFormat = DateFormat('d-MM-yyyy');
  Future<Null?> _selectDate(BuildContext context) async{

    DateTime? _datePicker = await showDatePicker(
      context: context,
      firstDate: DateTime(1947),
      lastDate: DateTime(2022),
      initialDate: _date,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        globals.dateOfBirth = _date;
        print(_date.toString(),);

        final DateTime? date2 = DateTime.now();
        int difference = date2!.difference(_date).inDays;

        print("gsghdhsagdshagdshgdjhgd: " + (difference/365).toString());
        globals.dateOfBirthCalc = (difference/365).round();
        print("gsghdhsagdshagdshgdjhgd: " + (globals.dateOfBirthCalc).toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
        margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 50.0,bottom: 25),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomStack(text: "Create your krowl account "),
        Column(
          children:[
        Container(
          width: 470,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade50),
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: col1,
              hintText: "First name",
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
              globals.fName = value;
              //print("" + globals.fName);
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
              fillColor: col2,
              hintText: "Last name",
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: col2_2,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: col2_1)),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              globals.lName = value;
              //print("" + globals.lName);
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
              fillColor: col3,
              hintText: "Username",
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: col3_2,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: col3_1)),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              globals.userName = value;
              //print("" + globals.userName);
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 470,
          child: TextFormField(
            controller: _datecontroller,
            cursorColor: Colors.blue.shade900,
            readOnly: true,
            onTap: (){
              setState(() {
                _selectDate(context);
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade50),
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.blue.shade50,
              labelText: "Date of birth",
              labelStyle: TextStyle( color: Colors.blue.shade900.withOpacity(0.5)),
              hintText: ('${myFormat.format(_date)}'),
              hintStyle: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 15.0,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade900, width: 2.0),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
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
            PreviousButton(text: "previous", color: blue1, icon: Icons.arrow_back, onTap: () {
              globals.fName = null;
              globals.lName = null;
              globals.userName= null;
              globals.dateOfBirth = null;
              globals.dateOfBirthCalc = null;
              Navigator.pop(context, '/intro_page2');
            }, ),
            Row(
              children: [
                Container(
                  width: 70,
                  margin: EdgeInsets.only(left: 100.sp),
                  child: NextButton(text: "Next", color: blue1, icon: Icons.arrow_forward,   onTap: () {

                    _test1();


                  }, ),
                ),
              ],
            ),
          ],
        ),

          ]),
          ),
      ),
    );
  }




  _test1(){

    bool if1 = false;
    bool if2 = false;
    bool if3 = false;
    bool if33 = false;
    bool if333 = false;
    bool if3333 = false;
    bool if4 = false;
    bool if44 = false;

    if (globals.fName != null) if (globals.fName!.isNotEmpty) if1 = true;

    if (globals.lName != null) if (globals.lName!.isNotEmpty) if2 = true;

    if (globals.userName != null) if (globals.userName!.isNotEmpty) {
      if3 = true; //empty or null
      if (!globals.userName!.contains(" "))
        if33 = true; //space
      if (globals.userName!.length >= 8)
        if333 = true; // 8 characters
      if (exp.hasMatch(globals.userName!))
        if3333 = true; //regular exp

    }

    if (globals.dateOfBirthCalc != null) {

      if4 = true;
      print(if4.toString());
      if (globals.dateOfBirthCalc! > 17)
        if44 = true;
    }


    if (if1) {
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
    }

    if (if2) {
      setState(() {
        col2 = Colors.blue.shade50;
        col2_1 = Colors.blue.shade900;
        col2_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    } else {
      setState(() {
        col2 = Colors.red.shade50;
        col2_1 = Colors.red.shade900;
        col2_2 = Colors.red.shade900.withOpacity(0.5);
      });
    }

    if (if3 && if33 && if333 && if3333) {
      setState(() {
        col3 = Colors.blue.shade50;
        col3_1 = Colors.blue.shade900;
        col3_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else if((if1 ==false || if2==false || if4==false) && if3 ==true){
      setState(() {
        col3 = Colors.blue.shade50;
        col3_1 = Colors.blue.shade900;
        col3_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else {
      setState(() {
        col3 = Colors.red.shade50;
        col3_1 = Colors.red.shade900;
        col3_2 = Colors.red.shade900.withOpacity(0.5);
      });
    }

    if (if4 && if44) {
      setState(() {
        col4 = Colors.blue.shade50;
        col4_1 = Colors.blue.shade900;
        col4_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else if((if1 ==false || if2==false || if3==false || if33==false || if333==false || if3333==false) && if4 ==true){
      setState(() {
        col4 = Colors.blue.shade50;
        col4_1 = Colors.blue.shade900;
        col4_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else {
      setState(() {
        col4 = Colors.red.shade50;
        col4_1 = Colors.red.shade900;
        col4_2 = Colors.red.shade900.withOpacity(0.5);
      });
    }

    if (if1 == true &&
        if2 == true &&
        if3 == true &&
        if4 == true) {
      if (if33 == true) {
        if (if333 == true) {
          if (if3333 == true) {
            if (if44 == true) {

              _reg();

            }else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          globals.error2_4),
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
          }else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error2_2),
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
              content: const Text(
                  "Your UserName must contains at least 8 characters."),
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
            content: const Text(
                "No Spaces allowed"),
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
          content: const Text("Fields can't be Empty."),
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








  _reg() async {
    globals.photo = "test";
    globals.terms = "test";
    globals.cropX = "test";
    globals.cropY = "test";
    globals.cropWidth = "test";
    globals.cropHeight = "test";

    if (globals.userName != null && globals.dateOfBirth !=null) {
      if (globals.userName!.isNotEmpty) {
        if (!globals.userName!.contains(" ")) {

          var data = {
            'username': globals.userName,
            'date_of_birth':globals.dateOfBirth.toString(),
          };
          var res = await CallApi().postData(
              data, '(Control)registration.php');
          print(res.body);
          List<dynamic> body = json.decode(res.body);
          if (body[0] == "success") {
            setState(() {
              col1 = Colors.blue.shade50;
              col1_1 = Colors.blue.shade900;
              col1_2 =
                  Colors.blue.shade900.withOpacity(0.5);
            });
            Navigator.pushNamed(context, '/Registration2');
          } else if (body[0] == "error1") {
            setState(() {
              col3 = Colors.red.shade50;
              col3_1 = Colors.red.shade900;
              col3_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error1),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error2_1") {
            setState(() {
              col3 = Colors.red.shade50;
              col3_1 = Colors.red.shade900;
              col3_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error2_1),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error2_2") {
            setState(() {
              col3 = Colors.red.shade50;
              col3_1 = Colors.red.shade900;
              col3_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error2_2),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error2_4") {
            setState(() {
              col4 = Colors.red.shade50;
              col4_1 = Colors.red.shade900;
              col4_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error2_4),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error5") {
            setState(() {
              col3 = Colors.red.shade50;
              col3_1 = Colors.red.shade900;
              col3_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error5),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else if (body[0] == "error7") {
            setState(() {
              col1 = Colors.red.shade50;
              col1_1 = Colors.red.shade900;
              col1_2 = Colors.red.shade900.withOpacity(0.5);

              col2 = Colors.red.shade50;
              col2_1 = Colors.red.shade900;
              col2_2 = Colors.red.shade900.withOpacity(0.5);

              col3 = Colors.red.shade50;
              col3_1 = Colors.red.shade900;
              col3_2 = Colors.red.shade900.withOpacity(0.5);

              col4 = Colors.red.shade50;
              col4_1 = Colors.red.shade900;
              col4_2 = Colors.red.shade900.withOpacity(0.5);
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        globals.error7),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
          else {
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
                        globals.errorElse),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                                context, 'OK'),
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
            col1_2 =
                Colors.red.shade900.withOpacity(0.5);
          });
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'No spaces Allowed .'),
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
        setState(() {
          col1 = Colors.red.shade50;
          col1_1 = Colors.red.shade900;
          col1_2 = Colors.red.shade900.withOpacity(0.5);
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content:
            const Text('Fields can not be empty.'),
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
                  'Field can not be null.'),
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
  }
}






