import 'package:flutter/material.dart';

class ReminderDropDown extends StatefulWidget {


  ReminderDropDown ({ this.onChanged, });
  var onChanged;
  @override
  State<ReminderDropDown> createState() => _ReminderDropDownState();
}

class _ReminderDropDownState extends State<ReminderDropDown> {

  String? dropdownValue;
  List gender = [
    '4',
    '5',
    '6',
    '7',
    '8'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17, right: 17),
      width: 220,
      height:40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            '8',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          value: dropdownValue,
          onChanged: (String? genderNewValue) {
            setState(
                  () {
                dropdownValue = genderNewValue;
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
    );

  }
}
