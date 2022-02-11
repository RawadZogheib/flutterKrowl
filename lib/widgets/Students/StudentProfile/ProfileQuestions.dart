import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Students/Students1/StudentButton.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileQuestions extends StatefulWidget {
  var TheQuestion;
  var contextQuestion;
  var dateOfQuestion;

  ProfileQuestions({
    required this.TheQuestion,
    required this.contextQuestion,
    required this.dateOfQuestion,

  });

  @override
  State<ProfileQuestions> createState() => _ProfileQuestionsState();
}

class _ProfileQuestionsState extends State<ProfileQuestions> {
  var NbrOfRepliesOnQuestion;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.TheQuestion, // this is the question
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.contextQuestion,
                  style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 10.0),
                      child: Text(
                        widget.dateOfQuestion, //this is the date
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Rubik',
                            color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "($NbrOfRepliesOnQuestion) Replies",
                      //these are the replies for that question
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          color: Colors.grey.shade600),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}