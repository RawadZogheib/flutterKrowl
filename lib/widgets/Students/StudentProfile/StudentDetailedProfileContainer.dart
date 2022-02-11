import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Students/Students1/StudentButton.dart';
import 'package:google_fonts/google_fonts.dart';


class StudentDetailedProfile extends StatefulWidget {
  var universityname;
  var username;
  var description;
  var color1; //light
  var color2; //dark
  bool isFriend;
  var onTap;

  StudentDetailedProfile({
    required this.universityname,
    required this.username,
    required this.isFriend,
    required this.description,
    this.color1,
    this.color2,
    this.onTap,
  });

  @override
  State<StudentDetailedProfile> createState() => _StudentDetailedProfileState();
}

class _StudentDetailedProfileState extends State<StudentDetailedProfile> {
  @override
  Widget build(BuildContext context) {
    var NbrOfFriends;
    return Container(
      width:  MediaQuery.of(context).size.width *
          0.57,
      height: MediaQuery.of(context).size.height *
          0.7,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.transparent,
          width: 1,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {},
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width,
                      image: AssetImage('Assets/CoverPhoto.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 90,
                    )
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height*0.17,
                    child: Avatar(
                      elevation: 3,
                      shape: AvatarShape.circle(MediaQuery.of(context).size.height*0.08,) ,
                      name: '${widget.username}',
                      placeholderColors: [globals.blue1],
                    )),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                        title: Center(
                            child: Text(
                              "${widget.username}",
                              style: GoogleFonts.archivoBlack(
                                  fontWeight: FontWeight.bold, fontSize: 23),
                            )),
                        subtitle: Center(
                            child: Text("${widget.universityname}",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600)))),
                  ),
                  Text(
                    widget.description, //this is the date
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Rubik',
                        color: Colors.grey.shade600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    child: Text(
                      "$NbrOfFriends Friends", //this is the date
                      style: GoogleFonts.nunito(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: globals.blue1),
                    ),
                  ),
                  widget.isFriend == true
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              bottom: 15, left: 10, right: 6),
                          child: StudentButton(
                            fontSize: 15,
                            height: 75,
                            text: "Unfriend",
                            textcolor: globals.blue1,
                            color1: globals.blue2,
                            color2: Colors.blueGrey,
                            onPressed: () {},
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 15, right: 15),
                          child: StudentButton(
                            fontSize: 15,
                            height: 75,
                            text: "Message",
                            textcolor: globals.blue1,
                            color1: globals.blue2,
                            color2: Colors.blueGrey,
                            onPressed: () {},
                          )),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 15, right: 15),
                          child: StudentButton(
                            height: 50,
                            text: "Add Friend",
                            fontSize: 15.0,
                            textcolor: globals.blue1,
                            color1: globals.blue2,
                            color2: Colors.blueGrey,
                            onPressed: () {},
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}