import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/components/chat.dart';
import 'package:flutter_app_backend/widgets/Chat/models/chat_users.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<ChatUsers> chatUsers = [
  //   ChatUsers(
  //       text: "Jane Russel",
  //       secondaryText: "Awesome Setup",
  //       image: "Assets/userImage1.jpeg",
  //       time: "Now"),
  //   ChatUsers(
  //       text: "Glady's Murphy",
  //       secondaryText: "That's Great",
  //       image: "Assets/userImage2.jpeg",
  //       time: "Yesterday"),
  //   ChatUsers(
  //       text: "Jorge Henry",
  //       secondaryText: "Hey where are you?",
  //       image: "Assets/userImage3.jpeg",
  //       time: "31 Mar"),
  //   ChatUsers(
  //       text: "Philip Fox",
  //       secondaryText: "Busy! Call me in 20 mins",
  //       image: "Assets/userImage4.jpeg",
  //       time: "28 Mar"),
  //   ChatUsers(
  //       text: "Debra Hawkins",
  //       secondaryText: "Thankyou, It's awesome",
  //       image: "Assets/userImage5.jpeg",
  //       time: "23 Mar"),
  //   ChatUsers(
  //       text: "Jacob Pena",
  //       secondaryText: "will update you in evening",
  //       image: "Assets/userImage6.jpeg",
  //       time: "17 Mar"),
  //   ChatUsers(
  //       text: "Andrey Jones",
  //       secondaryText: "Can you please share the file?",
  //       image: "Assets/userImage7.jpeg",
  //       time: "24 Feb"),
  //   ChatUsers(
  //       text: "John Wick",
  //       secondaryText: "How are you?",
  //       image: "Assets/userImage8.jpeg",
  //       time: "18 Feb"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTabBar(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Chats",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                      EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: globals.blue2,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: globals.blue1,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: globals.children2.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  text: globals.children2[index].text,
                  secondaryText: globals.children2[index].secondaryText,
                  image: globals.children2[index].image,
                  time: globals.children2[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  _loadContacts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");


    var data = {
      'version': globals.version,
      'user_id': user_id,
    };

    var res = await CallApi().postData(data, '(Control)loadContacts.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
        for (var i = 0; i < body[2].length; i++){
          globals.children2.add(
          ChatUsers(
              text: body[2][i][0],
              secondaryText: "will update you in evening",
              image: "Assets/userImage6.jpeg",
              time: "17 Mar"
        ),);
      };
      setState(() {
        globals.children2;
      });
    } else if (body[0] == "errorVersion") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              "Your version: " + globals.version + "\n" + globals.errorVersion),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "errorToken") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.errorToken),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error7") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error7),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (body[0] == "error11") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(globals.error11),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
