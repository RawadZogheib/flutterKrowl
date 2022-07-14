import 'package:flutter/material.dart';

import 'package:Krowl/globals/globals.dart' as globals;

class SearchBar extends StatelessWidget {

  SearchBar ({ this.text, this.onChanged, this.hintText });

  var text;
  var onChanged;
  var hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width*0.62,
      height: 40,
      child:Theme(
        data:ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.grey.shade400,
          ),
        ),
        child: TextField(
          onChanged: onChanged,
          textAlign: TextAlign.justify,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search, color:globals.blue_2),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:globals.blue_2 , width: 0.6),
                borderRadius: BorderRadius.circular(35),),

            hintText: '$hintText',
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: globals.blue_1.withOpacity(0.6))),
          ),
        ),
      ),
    );
  }
}
