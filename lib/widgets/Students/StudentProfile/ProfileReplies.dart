import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/page/Forum/ReplyPage.dart';
import 'package:flutter_app_backend/page/Responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileReplies extends StatefulWidget {
  var postId;
  var Id;
  var userName;
  var firstLastName;
  var Post_tag;
  int Post_val;
  var color;
  var color2;
  var TheAskedQuestion;
  var Post_context;
  var post_date;
  var DateOfReply;
  var reply;

  ProfileReplies({
    required this.postId,
    required this.Id,
    required this.userName,
    required this.firstLastName,
    required this.Post_tag,
    required this.Post_val,
    required this.color,
    required this.color2,
    required this.TheAskedQuestion,
    required this.Post_context,
    required this.post_date,
    required this.DateOfReply,
    required this.reply,
  });

  @override
  State<ProfileReplies> createState() => _ProfileRepliesState();
}

class _ProfileRepliesState extends State<ProfileReplies> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyPage(
                  id: widget.postId,
                  question: widget.TheAskedQuestion,
                  subject: widget.Post_tag,
                  username: widget.userName,
                  val: widget.Post_val,
                  color: widget.color,
                  color2: widget.color2,
                  contextQuestion: widget.Post_context,
                  date: widget.post_date),
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
                      "${widget.firstLastName} replied with:", //this is the date
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
                      "${widget.firstLastName} replied with:", //this is the date
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
                      "${widget.firstLastName} replied with:", //this is the date
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
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
