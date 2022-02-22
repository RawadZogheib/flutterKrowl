import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';


class UnansweredQuestions extends StatelessWidget{
  var height;
  var width;
  var text;
  var text2;
  String username;
  String question;
  String contextofquestion;
  var NbrReplies;
  var onTap;

  UnansweredQuestions({this.height, this.width,required this.username, required this.contextofquestion, required this.question, required this.NbrReplies, this.text, this.text2, this.onTap});

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
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
              Text('Unanswered Questions',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)
              ),
              SizedBox(height: 7),
              Text('Be the first to respond!',
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600)
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('Assets/userImage1.jpeg'),
                    maxRadius: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      username, //this is the username
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                          fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    question, // this is the question
                    style: GoogleFonts.nunito(
                      color: globals.blue1,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("$contextofquestion...",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                child: Row(
                  children: [
                    Icon(Icons.message,
                      color: Colors.black,
                      size: 15,
                    ),
                    SizedBox(width: 5,),
                    Text("$NbrReplies replies",
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
