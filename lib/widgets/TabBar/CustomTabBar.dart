import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;

class CustomTabBar extends StatelessWidget {

 CustomTabBar({  this.text,  });
 var text;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'Assets/krowl_logo.png',
          scale: 2.0,
        ),
        SizedBox(
          width: 500,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, '/Library', (route) => false);
            },
            child: Text("Library",
                style: TextStyle(
                  color: globals.blue1,
                  fontFamily: 'Rubik',
                  fontSize: 15,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, '/MainChat', (route) => false);
            },
            child: Text("Chat",
                style: TextStyle(
                  color: globals.blue1,
                  fontFamily: 'Rubik',
                  fontSize: 15,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, '/Forum1', (route) => false);
            },
            child: Text("Forum",
                style: TextStyle(
                  color: globals.blue1,
                  fontFamily: 'Rubik',
                  fontSize: 15,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
            },
            child: Text("Students",
                style: TextStyle(
                  color: globals.blue1,
                  fontFamily: 'Rubik',
                  fontSize: 15,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
            },
            child: Text("Reminders",
                style: TextStyle(
                  color: globals.blue1,
                  fontFamily: 'Rubik',
                  fontSize: 15,
                )),
          ),
        ),
        Icon(
          Icons.notifications_none_outlined,
          color: Colors.black,
          size: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage('Assets/userImage6.jpeg'),
            maxRadius: 20,
          ),
        ),
      ],
    );
  }
}
