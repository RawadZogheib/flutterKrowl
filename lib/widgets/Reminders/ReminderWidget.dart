import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Reminders/EditTextInput.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderWidget extends StatefulWidget {
  String ReminderContent;
  bool enabled;
  String dropdownValue;
  double hoursValue = 0;
  double minutesValue = 0;
  bool edit = false;

  ReminderWidget({
    required this.enabled,
    required this.ReminderContent,
    required this.dropdownValue,
    required this.hoursValue,
    required this.minutesValue,
  });

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState(
      ReminderContentTMP: ReminderContent,
      enabledTMP: enabled,
      dropdownValueTMP: dropdownValue,
      hoursValueTMP: hoursValue,
      minutesValueTMP: minutesValue);
}

class _ReminderWidgetState extends State<ReminderWidget> {

  //String? dropdownValue2;
  //String? dropdownValue3;

  List gender = [
    'every',
    'in',
  ];

  // List Time = [
  //   'minutes',
  //   'hours',
  // ];

  String ReminderContentTMP;
  bool enabledTMP;
  String dropdownValueTMP;
  double hoursValueTMP;
  double minutesValueTMP;

  _ReminderWidgetState(
      {required this.minutesValueTMP,
      required this.ReminderContentTMP,
      required this.enabledTMP,
      required this.dropdownValueTMP,
      required this.hoursValueTMP});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 750,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remind me ${widget.dropdownValue} ${widget.hoursValue.round()} Hours ${widget.minutesValue.round()}Minutes.",
                        //this is the date
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Rubik',
                            color: Colors.grey.shade500),
                      ),
                      widget.enabled == true
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.enabled = !widget.enabled;
                                    });
                                  },
                                  child: Icon(
                                    Icons.notifications,
                                    color: globals.blue1,
                                  ),
                                ),
                                PopupMenuButton<int>(
                                    tooltip: '',
                                    splashRadius: 0.1,
                                    onSelected: (item) =>
                                        onSelected(context, item),
                                    itemBuilder: (context) => [
                                          PopupMenuItem<int>(
                                            value: 0,
                                            child: Text("edit",
                                                style: TextStyle(
                                                    color: globals.blue1)),
                                          ),
                                          PopupMenuItem<int>(
                                            value: 1,
                                            child: Text("delete",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          )
                                        ]),
                              ],
                            )
                          : Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.enabled = !widget.enabled;
                                    });
                                  },
                                  child: Icon(
                                    Icons.notifications_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                PopupMenuButton<int>(
                                    tooltip: '',
                                    splashRadius: 0.1,
                                    onSelected: (item) =>
                                        onSelected(context, item),
                                    itemBuilder: (context) => [
                                          PopupMenuItem<int>(
                                            value: 0,
                                            child: Text("edit",
                                                style: TextStyle(
                                                    color: globals.blue1)),
                                          ),
                                          PopupMenuItem<int>(
                                            value: 1,
                                            child: Text("delete",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          )
                                        ]),
                              ],
                            ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, bottom: 20, right: 15, top: 7),
                child: Text(
                  widget.ReminderContent,
                  style: GoogleFonts.nunito(
                      fontSize: 17, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        widget.edit == true
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
                          FocusedBorderColor: globals.blue1,
                          BorderColor: globals.blue1,
                          suffixIcon: InkWell(
                              onTap: () {
                                print("Testing icon");
                              },
                              child: Icon(
                                Icons.done,
                                color: globals.blue1,
                                size: 30,
                              )),
                          hintText: widget.ReminderContent,
                          fillColor: Colors.white,
                          focusColor: globals.blue1,
                          cursorColor: globals.blue1,
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
                          color: globals.blue1,
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
                          value: widget.dropdownValue,
                          onChanged: (String? genderNewValue) {
                            setState(
                              () {
                                widget.dropdownValue =
                                    genderNewValue.toString();
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
                          widget.hoursValue.round().toString(),
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
                          widget.minutesValue.round().toString(),
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
                              value: widget.hoursValue,
                              onChanged: (double value) {
                                setState(() {
                                  widget.hoursValue = value;
                                  print(widget.hoursValue);
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
                              value: widget.minutesValue,
                              onChanged: (double value) {
                                setState(() {
                                  widget.minutesValue = value;
                                  print(widget.minutesValue);
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
                                widget.edit = !widget.edit;
                                ReminderContentTMP =widget.ReminderContent;
                                enabledTMP = widget.enabled;
                                dropdownValueTMP = widget.dropdownValue;
                                hoursValueTMP = widget.hoursValue;
                                minutesValueTMP = widget.minutesValue;
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
                              "Save",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Rubik',
                                  color: globals.blue2),
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
                                widget.edit = !widget.edit;
                                widget.ReminderContent = ReminderContentTMP;
                                widget.enabled = enabledTMP;
                                widget.dropdownValue = dropdownValueTMP;
                                widget.hoursValue = hoursValueTMP;
                                widget.minutesValue = minutesValueTMP;
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
                height: 15,
              )
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print("Clicked");
        setState(() {
          widget.edit = !widget.edit;
        });
        break;
      case 1:
        print("Clicked");
        setState(() {
          widget.edit = !widget.edit;
        });
        break;
    }
  }
}
