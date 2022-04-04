import 'package:flutter/material.dart';



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
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 0.7),
                borderRadius: BorderRadius.circular(5),),

            hintText: '$hintText',
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
      ),
    );
  }
}
