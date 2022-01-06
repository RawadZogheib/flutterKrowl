import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/components/streamChatt.dart';
import 'package:flutter_app_backend/widgets/Chat/components/chat.dart';
import 'package:flutter_app_backend/widgets/Chat/models/chat_users.dart';
import 'package:flutter_app_backend/widgets/TabBar/CustomTabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat/stream_chat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var client;
  var channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.children2.clear();
    _loadContacts();
  }

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
                  id: globals.children2[index].user_id,
                  text: globals.children2[index].text,
                  secondaryText: globals.children2[index].secondaryText,
                  image: globals.children2[index].image,
                  time: globals.children2[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                  ontap: () => _goToChat(
                    globals.children2[index].friendShipId,
                    globals.children2[index].text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  initChat(var channelName) async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var usernameChat=localStorage.getString("username");
    var userToken;


      const apiKey = "z5j34vkctqrq";
      userToken = globals.userTokenChat; //should be sent by the server

      print("ddddddddddddddddddddddddd" + userToken!);

      client = StreamChatClient(apiKey, logLevel: Level.INFO);

      await client.connectUser(
        User(
          id: usernameChat!,
          //name: 'Cool Shadow',
          // image:
          // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
        ),
        userToken,
      );

      channel = client.channel('messaging', id: channelName);

      await channel.watch();
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
      for (var i = 0; i < body[2].length; i++) {
        globals.children2.add(
          ChatUsers(
              text: body[2][i][1],
              secondaryText: "will update you in evening",
              image: "Assets/userImage6.jpeg",
              time: "17 Mar",
              user_id: body[2][i][0],
              friendShipId: body[2][i][2]),
        );
      }
      ;
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

  _goToChat(var channelName, var name) async {
    await initChat(channelName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StreamExample(
          client: client,
          channel: channel,
          name: name,
        ),
      ),
    );
  }
}

class ChatPage2 extends StatefulWidget {
  @override
  _ChatPage2State createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  var client;
  var channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.children2.clear();
    _loadFriends();
  }

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
                  id: globals.children2[index].user_id,
                  text: globals.children2[index].text,
                  secondaryText: globals.children2[index].secondaryText,
                  image: globals.children2[index].image,
                  time: globals.children2[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                  ontap: () => _goToChat(
                    globals.children2[index].friendShipId,
                    globals.children2[index].text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _loadFriends() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = localStorage.getString("user_id");

    var data = {
      'version': globals.version,
      'user_id': user_id,
    };

    var res = await CallApi().postData(data, '(Control)loadFriends.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }

    if (body[0] == "success") {
      for (var i = 0; i < body[2].length; i++) {
        globals.children2.add(
          ChatUsers(
              text: body[2][i][1],
              secondaryText: "will update you in evening",
              image: "Assets/userImage6.jpeg",
              time: "17 Mar",
              user_id: body[2][i][0],
              friendShipId: body[2][i][2]),
        );
      }
      ;
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

  _goToChat(var channelName, var name) async {
    await initChat(channelName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StreamExample(
          client: client,
          channel: channel,
          name: name,
        ),
      ),
    );
  }

  initChat(var channelName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userTokenChat;
    var usernameChat;
    var user_id = localStorage.getString("user_id");
    var data = {'version': globals.version, 'user_id': user_id};

    var res = await CallApi().postData(data, '(Control)generateTokenChat.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }
    if (body[0] == "success") {
      userTokenChat = body[2];
      usernameChat = body[3];

      const apiKey = "z5j34vkctqrq";
      //const userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUmF3YWQifQ.zY0MNdMd9huVSk_eIqfMvoYVGA0urn-hpwKPbafYrjg"; //should be sent by the server
      var userToken = userTokenChat;
      //should be sent by the server
      print("ddddddddddddddddddddddddd" + userToken);

      client = StreamChatClient(apiKey, logLevel: Level.INFO);

      await client.connectUser(
        User(
          id: usernameChat,
          //name: 'Cool Shadow',
          // image:
          // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
        ),
        userToken,
      );

      channel = client.channel('messaging', id: channelName);

      await channel.watch();
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
    }
  }
}
