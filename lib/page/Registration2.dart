import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
));

class Registration2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            children: <Widget>[
              Container(
                child: (
                    Image(
                      image: AssetImage('Assets/Register.png'),
                    )),),
              Container(
                alignment: Alignment.bottomLeft,
                width: 250,
                height: 130,
                child:(
                    Text(
                      'Create your krowl account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        fontFamily: 'Rubik',
                        fontSize: 35,
                      ),
                    )
                ),),

            ],
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Find your university",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Find your major(s)",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 470,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: "Find your minor(s)",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
                border: InputBorder.none,
                focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      Text("previous",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontFamily: 'Rubik',
                            fontSize: 20,
                          )),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context, '/Registration');
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 100.sp),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("next",
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontFamily: 'Rubik',
                                fontSize: 20,
                              )),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 25,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/Registration3');
                      },
                    ),
                  ),
                ],
              ),


            ],),
        ]),
      ),
    );
  }
}
