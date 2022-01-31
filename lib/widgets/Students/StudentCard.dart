import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Students/StudentButton.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentCard extends StatefulWidget {
  String userId;
  String username;
  String universityname;
  bool isFriend;
  var userImg;
  var color1; //light
  var color2; //dark
  var onTap;

  StudentCard({
    required this.userId,
    required this.username,
    required this.universityname,
    required this.isFriend,
    this.userImg,
    this.color1,
    this.color2,
    this.onTap,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.all(6.0),
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
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      image: AssetImage('Assets/CoverPhoto.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                ),
                Positioned(
                    top: 50,
                    child: widget.userImg.isEmpty
                        ?Avatar(
                      elevation: 3,
                      shape: AvatarShape.circle(27),
                      name: '${widget.username}',
                      placeholderColors: [globals.blue1],
                    )
                :Image.network(globals.myIP + '/' + widget.userImg),
                ),
              ]),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                        title: Center(
                            child: Text(
                          "${widget.username}",
                          style: GoogleFonts.archivoBlack(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                        subtitle: Center(
                            child: Text("${widget.universityname}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600)))),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Visibility(
                  //       visible: !widget.isFriend,
                  //       maintainState: true,
                  //       maintainAnimation: true,
                  //       maintainSize: true,
                  //       child: Container(
                  //           margin:
                  //               EdgeInsets.only(bottom: 15, left: 10, right: 6),
                  //           child: StudentButton(
                  //             text: "Add Friend",
                  //             textcolor: globals.blue1,
                  //             color1: globals.blue2,
                  //             color2: Colors.blueGrey,
                  //             onPressed: () {},
                  //           )),
                  //     ),
                  //     Container(
                  //         margin: EdgeInsets.only(bottom: 15, right: 15),
                  //         child: StudentButton(
                  //           text: "Add Friend",
                  //           textcolor: globals.blue1,
                  //           color1: globals.blue2,
                  //           color2: Colors.blueGrey,
                  //           onPressed: () {},
                  //         ))
                  //   ],
                  // ),
                  widget.isFriend == true
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    bottom: 15, left: 10, right: 6),
                                child: StudentButton(
                                  text: "Unfriend",
                                  textcolor: globals.blue1,
                                  color1: globals.blue2,
                                  color2: Colors.blueGrey,
                                  onPressed: () {},
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 15, right: 15),
                                child: StudentButton(
                                  text: "Message",
                                  textcolor: globals.blue1,
                                  color1: globals.blue2,
                                  color2: Colors.blueGrey,
                                  onPressed: () {},
                                )),
                          ],
                        )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 15, right: 15),
                              child: StudentButton(
                                text: "Add Friend",
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

//InkWell(
//               onTap: onTap,
//               child: Transform.rotate(
//                 angle: -180 * 3.14159265359 / 180,),
//             ),
