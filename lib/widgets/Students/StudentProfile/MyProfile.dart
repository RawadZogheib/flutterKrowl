import 'package:Krowl/globals/globals.dart' as globals;
import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myProfile extends StatefulWidget {
  var userId;
  var username;
  var universityName;
  var description;
  int nbrOfFriends;
  String isFriend;
  var color1; //light
  var color2; //dark
  var onTap;

  myProfile({
    required this.userId,
    required this.username,
    required this.universityName,
    required this.description,
    required this.isFriend,
    required this.nbrOfFriends,
    this.color1,
    this.color2,
    this.onTap,
  });

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  bool _loadButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.57,
      height: MediaQuery.of(context).size.height * 0.7,
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
        child: Column(
          children: [
            Stack(alignment: Alignment.center, children: [
              Column(
                children: [
                  Image(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage('Assets/CoverPhoto.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 110,
                  )
                ],
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.19,
                  child: Avatar(
                    elevation: 3,
                    shape: AvatarShape.circle(
                      MediaQuery.of(context).size.height * 0.08,
                    ),
                    name: '${widget.username}',
                    placeholderColors: [globals.blue1],
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.30,
                right: MediaQuery.of(context).size.width * 0.24,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: InkWell(
                    child: CircleAvatar(
                      child:  Icon(Icons.person_add_alt_1_rounded,color: Colors.white, size: 19,),
                      backgroundColor: globals.blue1,
                      maxRadius: 17,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
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
                          child: Text("${widget.universityName}",
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
                    "${widget.nbrOfFriends.toString()} Friends",
                    //this is the date
                    style: GoogleFonts.nunito(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: globals.blue1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToMessage() {
    //Go To Message
  }
}
