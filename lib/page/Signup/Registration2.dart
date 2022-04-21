import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Krowl/Data/Degree_data.dart';
import 'package:Krowl/Data/University_data.dart';
import 'package:Krowl/api/my_api.dart';
import 'package:Krowl/globals/globals.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:Krowl/widgets/Buttons/NextButton.dart';
import 'package:Krowl/widgets/Buttons/PreviousButton.dart';
import 'package:Krowl/widgets/PopUp/errorWarningPopup.dart';
import 'package:Krowl/widgets/Stack.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sizer/sizer.dart';

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
  final controllerCity1 = TextEditingController();
  final controllerCity2 = TextEditingController();
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _getLists();
  }
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
              if (globals.uniId != null &&
                  globals.majorId != null &&
                  globals.minorId != null) {
                Navigator.pushNamed(context, '/Registration3');
              } else {
                WarningPopup(context, globals.warning7);
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
              margin: EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 25),
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
                    Container(width: 470, child: buildCity2()),
                    SizedBox(
                      height: 20,
                    ),
                    Container(width: 470, child: buildCity3()),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PreviousButton(
                      text: "previous",
                      color: blue1,
                      icon: Icons.arrow_back,
                      onTap: () {
                        globals.uniId = null;
                        globals.majorId = null;
                        globals.minorId = null;
                        Navigator.pop(context, '/Registration');
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          margin: EdgeInsets.only(left: 100.sp),
                          child: NextButton(
                            text: "next",
                            color: blue1,
                            icon: Icons.arrow_forward,
                            onTap: () {
                              if (globals.uniId != null &&
                                  globals.majorId != null &&
                                  globals.minorId != null) {
                                Navigator.pushNamed(context, '/Registration3');
                              } else {
                                WarningPopup(context, globals.warning7);
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
          ),
        ),
      ),
    );
  }

  _getLists() async {
    var data = {
      'version': globals.version
    };
    var res = await CallApi().postData(data, '(Control)registration2.php');

    List<dynamic> body = json.decode(res.body);
    print(body);
    print("sdfsdfsdf");
    //print(body[0][0]);

    if (body[0] == "success") {
      print("sdfsdfsdf555555555555555");
      //setState(() {
      //globals.univercitiesName = body[1];
      //print(globals.univercitiesName[1]); correct writing => print(globals.univercitiesName);
      for (int i = 0; i < body[1].length; i++) {
        globals.univercitiesName
            .add(body[1][i].toString().replaceAll("[", "").replaceAll("]", ""));
        //print(globals.univercitiesName);
      }

      for (int i = 0; i < body[2].length; i++) {
        globals.degrees
            .add(body[2][i].toString().replaceAll("[", "").replaceAll("]", ""));
        //print(globals.degrees);
      }

      //globals.degrees = body[2].cast<String>();
      //});
      print("asdasdsadsadsadsdsd");
    } else if (body[0] == "errorVersion") {
      ErrorPopup(context, globals.errorVersion);
    }else if (body[0] == "errorToken") {
      ErrorPopup(context, globals.errorToken);
    } else if (body[0] == "error4") {
      ErrorPopup(context, globals.error4);
    }
  }

  Widget buildCity() => TypeAheadFormField<dynamic>(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: (){},
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
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900)),
          ),
          controller: controllerCity,
        ),
        suggestionsCallback: CityData.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
    onSuggestionSelected: (dynamic suggestion) {
      controllerCity.text = suggestion!;
      globals.uniId = suggestion!;
      print(globals.uniId);
    },
      );

  Widget buildCity2() => TypeAheadFormField<dynamic>(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: (){},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade50),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.blue.shade50,
            hintText: "Find your Major",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blue.shade900,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900)),
          ),
          controller: controllerCity1,
        ),
        suggestionsCallback: CityData2.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
    onSuggestionSelected: (dynamic suggestion) {
      controllerCity1.text = suggestion!;
      globals.majorId = suggestion!;
      print(globals.majorId);
    },
      );

  Widget buildCity3() => TypeAheadFormField<dynamic>(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          onEditingComplete: (){},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade50),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.blue.shade50,
            hintText: "Find your Minor",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blue.shade900,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900)),
          ),
          controller: controllerCity2,
        ),
        suggestionsCallback: CityData2.getSuggestions,
        itemBuilder: (context, dynamic suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (dynamic suggestion) {
            controllerCity2.text = suggestion!;
            globals.minorId = suggestion!;
            print(globals.minorId);
        },
      );

  _back() {
    globals.uniId = null;
    globals.majorId = null;
    globals.minorId = null;
    return true;
  }
}
