import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Forum/Dropdown2.dart';
import 'package:flutter_app_backend/widgets/TextInput1.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


class CreatePost extends StatefulWidget {
  var children;
  var onTap;

  CreatePost ({ this.children,this.onTap });


  @override
  State<CreatePost> createState() => _CreatePostState();

}

class _CreatePostState extends State<CreatePost> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 540,
          height: 500,
          padding: EdgeInsets.only(left: 25, right: 25, top: 45, bottom: 45),
          decoration:
          BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: globals.blue2,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subject *",
                style:  GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              Container( padding: EdgeInsets.only(top: 20),child: Dropdown2()),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Question *",
                  style:  GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 450,
                    height: 40,
                    child: TextInput1(fillColor: Colors.white,)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Context of question *",
                  style:  GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),

            ],
          ),
        ),


      ],
    );

  }
}
