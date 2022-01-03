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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamed(context, '/Library');
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
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamed(context, '/MainChat');
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
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.pushNamed(context, '/Forum1');
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
          padding: const EdgeInsets.all(15.0),
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
        )
      ],
    );
  }
}
