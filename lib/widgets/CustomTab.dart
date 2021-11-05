import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';




class CustomTab extends StatelessWidget {

  CustomTab ({required this.title,  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
      this.title,
          style: TextStyle(fontFamily: "Rubik", fontSize: 15,),
      ),
    );
  }
}
