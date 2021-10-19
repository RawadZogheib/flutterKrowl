import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart';
import 'package:flutter_app_backend/widgets/NextButton.dart';
import 'package:flutter_app_backend/widgets/PreviousButton.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Stack.dart';
import 'package:flutter_app_backend/Data/University_data.dart';



void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Registration2 extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<Registration2> createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  final controllerCity = TextEditingController();
  String? selectedCity;
  @override
  void initState() {
    super.initState();
    _getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, top:100, bottom: 25),
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomStack(text: "Create your krowl account"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 470,
                    child: buildCity(),
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
                        hintText: "Find your major(s)",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue.shade900,
                        ),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value){
                        globals.majorId = value;
                        //print("" + globals.minorId);
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
                        hintText: "Find your minor(s)",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue.shade900,
                        ),
                        border: InputBorder.none,
                        focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue.shade900)),
                      ),
                      textInputAction: TextInputAction.done,
                      onChanged: (value){
                        globals.minorId = value;
                        //print("" + globals.minorId);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PreviousButton(text: "previous", color:blue1 ,icon: Icons.arrow_back,
                    onTap: () {
                      globals.uniId = null;
                      globals.majorId = null;
                      globals.minorId= null;
                    Navigator.pop(context, '/Registration');
                  },),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.only(left: 100.sp),
                        child: NextButton(text: "next", color: blue1, icon: Icons.arrow_forward,   onTap: () {if (globals.uniId != null && globals.majorId != null && globals.minorId != null) {
                          Navigator.pushNamed(context, '/Registration3');
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Those fields can not be empty.'),
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
                        },),
                      ),
                    ],
                  ),


                ],),
            ]),
          ),
        ),
    );
  }

  _getLists() async {
    var data = {};
    var res = await CallApi().postData(data,'(Control)registration2.php');

    List<dynamic> body = json.decode(res.body);
    print(body[0]);
    print("sdfsdfsdf");
    //print(body[0][0]);

    if (body[0] == "[\"success\"]") {

      //setState(() {
        //globals.univercitiesName = body[1];
        //globals.univercitiesName = body[2];
     // });
      print("asdasdsadsadsadsdsd");
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
    }
  }
  Widget buildCity() => TypeAheadFormField<dynamic>(
    textFieldConfiguration: TextFieldConfiguration(

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade50),
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.blue.shade50,
        hintText: "Find your university",
        hintStyle: TextStyle(
          fontSize: 15.0,
          color: Colors.blue.shade900,
        ),
        border: InputBorder.none,
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade900)),

      ),
      controller: controllerCity,
    ),
    suggestionsCallback: CityData.getSuggestions ,
    itemBuilder: (context, dynamic suggestion) => ListTile(title: Text(suggestion!),
    ),
    onSuggestionSelected: (dynamic suggestion) => controllerCity.text = suggestion! ,
    onSaved: (value) => selectedCity = value,


  );
}

