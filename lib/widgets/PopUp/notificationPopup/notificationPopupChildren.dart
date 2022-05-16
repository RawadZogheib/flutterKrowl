import 'package:Krowl/globals/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPopupChildren extends StatefulWidget {
  var onChanged;
  var username;

  NotificationPopupChildren({
    Key? key,
    this.onChanged,
    required this.username,
  }) : super(key: key);

  @override
  _NotificationPopupChildrenState createState() =>
      _NotificationPopupChildrenState();
}

class _NotificationPopupChildrenState extends State<NotificationPopupChildren> {
  bool SentFriendRequest = false;
  bool AcceptedFriendRequest = false;
  bool SentMessage = false;
  bool StartedCall = true;

  GlobalKey _toolTipKey = GlobalKey();

  int val = -1;
  var color1 = Colors.grey.shade400;
  bool IconSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 250,
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final dynamic tooltip = _toolTipKey.currentState;
                      tooltip.ensureTooltipVisible();
                    },
                    child: Tooltip(
                        key: _toolTipKey,
                        message: 'Mark as unread',
                        child: IconSelected == true
                            ? IconButton(
                                splashRadius: 0.1,
                                iconSize: 20,
                                color: color1,
                                icon: Icon(Icons.bookmark_outlined),
                                onPressed: () {
                                  setState(() {
                                    color1 = globals.blue1;
                                    IconSelected = true;
                                  });
                                })
                            : IconButton(
                                splashRadius: 0.1,
                                iconSize: 20,
                                color: color1,
                                icon: Icon(Icons.bookmark_outlined),
                                onPressed: () {
                                  setState(() {
                                    color1 = Colors.grey.shade400;
                                  });
                                })),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("Assets/userImage1.jpeg"),
                      maxRadius: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4),
                            child: Text(
                              widget.username,
                              style: GoogleFonts.archivoBlack(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          (SentFriendRequest == true
                              ? Icon(
                                  Icons.people,
                                  color: globals.blue1,
                                  size: 23,
                                )
                              : (AcceptedFriendRequest == true
                                  ? Icon(
                                      Icons.person_add_alt_1_rounded,
                                      color: globals.blue1,
                                      size: 23,
                                    )
                                  : (SentMessage == true
                                      ? Icon(
                                          Icons.chat_bubble,
                                          color: globals.blue1,
                                          size: 23,
                                        )
                                      : (StartedCall == true
                                          ? Icon(
                                              Icons.videocam,
                                              color: globals.blue1,
                                              size: 23,
                                            )
                                          : Container()))))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: (SentFriendRequest == true
                            ? Text("sent you a friend request",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                    fontSize: 14, color: Colors.black))
                            : (AcceptedFriendRequest == true
                                ? Text("accepted your friend request",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                        fontSize: 14, color: Colors.black))
                                : (SentMessage == true
                                    ? Text("sent you a message",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                            fontSize: 14, color: Colors.black))
                                    : (StartedCall == true
                                        ? Text("started a call",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                color: Colors.black))
                                        : Container())))),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
