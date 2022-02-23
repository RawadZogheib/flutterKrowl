import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/page/Forum/ReplyPage.dart';
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileQuestions extends StatefulWidget {
  var Id;
  var firstLastName;
  var Post_tag;
  int Post_val;
  var color;
  var color2;
  var TheQuestion;
  var contextQuestion;
  var nbrOfReplies;
  var dateOfQuestion;

  ProfileQuestions({
    required this.Id,
    required this.firstLastName,
    required this.Post_tag,
    required this.Post_val,
    required this.color,
    required this.color2,
    required this.TheQuestion,
    required this.contextQuestion,
    required this.nbrOfReplies,
    required this.dateOfQuestion,
  });

  @override
  State<ProfileQuestions> createState() => _ProfileQuestionsState();
}

class _ProfileQuestionsState extends State<ProfileQuestions> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyPage(
                  id: widget.Id,
                  question: widget.TheQuestion,
                  subject: widget.Post_tag,
                  username: widget.firstLastName,
                  val: widget.Post_val,
                  color: widget.color,
                  color2: widget.color2,
                  contextQuestion: widget.contextQuestion,
                  date: widget.dateOfQuestion),
            ),
                (route) => false);
      },
      child: Responsive(
        mobile: Padding(
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.dateOfQuestion, //this is the date
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "(${widget.nbrOfReplies}) Replies",
                            //these are the replies for that question
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
        tablet: Padding(
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.dateOfQuestion, //this is the date
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "(${widget.nbrOfReplies}) Replies",
                            //these are the replies for that question
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
        desktop: Padding(
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.dateOfQuestion, //this is the date
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "(${widget.nbrOfReplies}) Replies",
                            //these are the replies for that question
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Rubik',
                                color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
