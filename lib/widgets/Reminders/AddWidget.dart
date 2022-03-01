import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Reminders/EditTextInput.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWidget extends StatefulWidget {
  bool _addBool = false;

  AddWidget({
    this.onChanged,
  });

  var onChanged;

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  String? _dropdownValue;
  List gender = [
    'every',
    'in',
  ];
  List Time = [
    'minutes',
    'hours',
  ];
  double _value1 = 0;
  double _value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(left: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onTap: () {
              setState(() {
                widget._addBool = !widget._addBool;
              });
              print("Testingg");
            },
            child: Icon(Icons.add, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        widget._addBool == true
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Content *",
                      style:
                          GoogleFonts.nunito(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: 550,
                        child: EditTextInput(
                          FocusedBorderColor: Colors.grey.shade400,
                          BorderColor: Colors.grey.shade400,
                          hintText: "ReminderContent",
                          fillColor: Colors.white,
                          focusColor: Colors.grey.shade400,
                          cursorColor: Colors.grey.shade400,
                        )),
                    SizedBox(height: 15),
                    Text(
                      "When do you want to receive this reminder ? *",
                      style:
                          GoogleFonts.nunito(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 17, right: 17),
                      width: 550,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            'every',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          value: _dropdownValue,
                          onChanged: (String? genderNewValue) {
                            setState(
                              () {
                                _dropdownValue = genderNewValue;
                              },
                            );
                          },
                          items: gender.map<DropdownMenuItem<String>>(
                            (value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          _value1.round().toString(),
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          "Hrs",
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _value2.round().toString(),
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          "min",
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Hours:",
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 550,
                          child: Slider(
                              min: 0,
                              max: 59,
                              divisions: 59,
                              activeColor: Colors.blueGrey,
                              inactiveColor: globals.blue2,
                              thumbColor: globals.blue1,
                              value: _value1,
                              onChanged: (double value) {
                                setState(() {
                                  _value1 = value;
                                  print(_value1);
                                });
                              }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Minutes:",
                          style: GoogleFonts.nunito(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 550,
                          child: Slider(
                              min: 0,
                              max: 59,
                              divisions: 59,
                              activeColor: Colors.blueGrey,
                              inactiveColor: globals.blue2,
                              thumbColor: globals.blue1,
                              value: _value2,
                              onChanged: (double value) {
                                setState(() {
                                  _value2 = value;
                                  print(_value2);
                                });
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              print("Clicked Save");
                              setState(() {
                                widget._addBool = !widget._addBool;
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        globals.blue1),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        side:
                                            BorderSide(color: globals.blue1)))),
                            child: Text(
                              "Create",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Rubik',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 90,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              print("Clicked Cancel");
                              setState(() {
                                widget._addBool = !widget._addBool;

                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        globals.blue2),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        side:
                                            BorderSide(color: globals.blue2)))),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Rubik',
                                  color: globals.blue1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: 10,
              ),
      ],
    );
  }
}
