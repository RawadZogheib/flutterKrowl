import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  var height;
  var width;
  var text;
  var color = Colors.grey.shade600;
  var color2 = Colors.grey.shade600;
  var onTap;

  Question({this.height, this.width, this.text, this.onTap});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int _like = 0;
  int _dislike = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 730,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('#science',
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Rubik',
                            color: globals.blue1)),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 500,
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Hey everyone! Quick question about COVID and the antibodies. I just read an article stating that even if you have the antibodies, you can still catch a different strain... What do you think about this?',
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("Assets/userImage1.jpeg"),
                          maxRadius: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Jane Russel",
                        style: TextStyle(color: globals.blue1, fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _like += 1;
                        widget.color = globals.blue1;
                        widget.color2 = Colors.grey.shade600;
                      });
                    },
                    child: Icon(Icons.thumb_up,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('$_like'),
                  SizedBox(height: 8,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _like -=1;
                        widget.color2 = globals.blue1;
                        widget.color = Colors.grey.shade600;
                      });
                    },
                    child: Icon(Icons.thumb_down,
                      color: widget.color2,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
