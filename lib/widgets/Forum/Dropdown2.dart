import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dropdown2 extends StatefulWidget {


  Dropdown2 ({ this.onChanged, });
  var onChanged;
  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

class _Dropdown2State extends State<Dropdown2> {

  String? dropdownValue;
  List subject = [
    'science',
    'biology',
    'math',
    'english',
    'other'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17, right: 17),
      width: 450,
      height:40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            'Choose a subject',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 17,
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
          items: subject.map<DropdownMenuItem<String>>(
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
