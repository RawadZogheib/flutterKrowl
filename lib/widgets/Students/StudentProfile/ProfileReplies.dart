import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:flutter_app_backend/widgets/Students/Students1/StudentButton.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileReplies extends StatefulWidget {
  var TheAskedQuestion;
  var DateOfReply;
  var reply;

  ProfileReplies({
    required this.TheAskedQuestion,
    required this.DateOfReply,
    required this.reply,

  });

  @override
  State<ProfileReplies> createState() => _ProfileRepliesState();
}

class _ProfileRepliesState extends State<ProfileReplies> {
  var username;
  var NbrOfRepliesOnQuestion;
  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Widget
              Text(
                widget.TheAskedQuestion, // this is the question
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Text(
                  "$username replied with:", //this is the date
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Rubik',
                      color: Colors.grey.shade400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.reply, //this is the reply of the user
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.DateOfReply, //this is the date of the reply
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ), tablet: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Widget
              Text(
                widget.TheAskedQuestion, // this is the question
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Text(
                  "$username replied with:", //this is the date
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Rubik',
                      color: Colors.grey.shade400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.reply, //this is the reply of the user
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.DateOfReply, //this is the date of the reply
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ), desktop: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.54,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Widget
              Text(
                widget.TheAskedQuestion, // this is the question
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Text(
                  "$username replied with:", //this is the date
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Rubik',
                      color: Colors.grey.shade400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.reply, //this is the reply of the user
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.DateOfReply, //this is the date of the reply
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}