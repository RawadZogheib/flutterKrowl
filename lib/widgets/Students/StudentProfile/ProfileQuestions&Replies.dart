import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/ProfileQuestions.dart';
import 'package:flutter_app_backend/widgets/Students/StudentProfile/ProfileReplies.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentQuestionsReplies extends StatefulWidget {

  List<ProfileQuestions> children1 = [];
  List<ProfileReplies> children2 = [];


  StudentQuestionsReplies({required this.children1, required this.children2});

  @override
  State<StudentQuestionsReplies> createState() =>
      _StudentQuestionsRepliesState();
}

class _StudentQuestionsRepliesState extends State<StudentQuestionsReplies> {
  bool Questions = true;
  bool Replies = true;
  var username;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(4),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // These are the questions asked from this student on krowl

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Questions)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text("Questions (${widget.children1.length})",
                                // this is the number of replies
                                style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    if (!Questions)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.54,
                                child: Row(
                                  children: [
                                    Text("Questions (${widget.children1.length})",
                                        // this is the number of replies
                                        style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ),

                            Column(
                              children: widget.children1,
                            ),
                            // This is a widget for the questions
                          ],
                        ),
                      )
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 20,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Questions = !Questions;
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
            ],
          ),
          Container(
            height: 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Colors.grey.shade500,
          ),

          // These are the Replies answered from this student on krowl questions

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Replies)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Replies (${widget.children2.length})",
                                        // this is the number of replies
                                        style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!Replies)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Replies (${widget.children2.length})",
                                        // this is the number of replies
                                        style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ),

                            Column(
                              children: widget.children2,
                            ),
                            //This is a widget for the replies
                          ],
                        ),
                      )
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 20,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Replies = !Replies;
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
