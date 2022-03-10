import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';


class Contributors extends StatefulWidget {
  var height;
  var width;
  var text;
  var text2;
  var color = Colors.grey.shade600;
  var color2 = Colors.grey.shade600;
  var onTap;

  Contributors({this.height, this.width, this.text, this.text2, this.onTap});

  @override
  State<Contributors> createState() => _Contributors();
}

class _Contributors extends State<Contributors> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 0.5,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Top Contributors',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)
              ),
              SizedBox(height: 7),
              Text('Students with the most questions and replies combined.',
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600)
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('CherifKanaan',
                      style: GoogleFonts.nunito(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.message,
                    color: globals.blue1,
                    size: 17,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
