import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Buttons/RadioButton.dart';
import 'package:flutter_app_backend/widgets/Dropdown.dart';
import 'package:flutter_app_backend/widgets/Library/CustomTable.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTable extends StatefulWidget {
  var children;
  var onTap;

  CreateTable({this.children, this.onTap});

  @override
  State<CreateTable> createState() => _NextButtonState();
}

class _NextButtonState extends State<CreateTable> {
  String? dropdownValue;
  List gender = ['4', '5', '6', '7', '8'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 250,
          height: 415,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 65,
                  ),
                  Text(
                    "Create a Table",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Table Name *",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Rubik', color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 220,
                  height: 40,
                  child: TextInput1(
                    onChanged: (val) {
                      globals.tableName = val;
                      print(globals.tableName.toString());
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Number of Seats *",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Rubik', color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Dropdown1(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 88, child: TableButton(text: "Quiet", index: '3')),
                  Container(
                      width: 95, child: TableButton(text: "Silent", index: '3'))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TableButton(text: "Public", index: 3),
              //     SizedBox(
              //       width: 35,
              //     ),
              //     TableButton(text: "Private", index: 4)
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 95,
                    child: TableButton(
                      text: "Public",
                      index: '1',
                      onPressed: () {
                        setState(() {
                          globals.selectedPublicPrivet = '1';
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 95,
                    child: TableButton(
                      text: "Privet",
                      index: '2',
                      onPressed: () {
                        setState(() {
                          globals.selectedPublicPrivet = '2';
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 220,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _createTable();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(globals.blue1),
                      shadowColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: globals.blue1)))),
                  child: Text(
                    'Create Table',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Rubik',
                        color: globals.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _createTable() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");
    var user_uni = localStorage.getString("user_uni");
    print(TextInput1().toString());

    String table_type;
    (globals.selectedPublicPrivet == '1')
        ? table_type = '1'
        : ((globals.selectedPublicPrivet == '2') ? table_type = '2' : table_type =
    '');
    print(table_type);

    var data = {
      'version': globals.version,
      'user_id': user_id,
      'table_uni':user_uni,
      'table_name': globals.tableName.toString(),
      'seats': '8',
      'table_type': table_type,
    };

    var res = await CallApi().postData(data, '(Control)createTable.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);

    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
      widget.onTap();
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  "Your version: " + globals.version + "\n" +
                      globals.errorVersion),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.errorToken),
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
    } else if (body[0] == "error10") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text(globals.error10),
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
