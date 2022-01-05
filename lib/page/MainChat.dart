import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/page/Chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import '../widgets/Chat/modules/chat_page.dart';

class MainChat extends StatefulWidget {
  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  var client;

  var channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await initChat();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamExample(
                client: client,
                channel: channel,
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Friends",
          ),
        ],
      ),
      body: ChatPage(),
    );
  }
  initChat() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userTokenChat;
    var usernameChat;
    var data = {
      'version': globals.version,
      'user_id': 1
    };

    var res = await CallApi().postData(
        data, '(Control)generateTokenChat.php');
    print(res.body);
    List<dynamic> body = json.decode(res.body);
    try {
      localStorage.setString('token', body[1]);
    } catch (e) {
      print('no token found');
    }
    if (body[0] == "success") {
      userTokenChat=body[2];
      usernameChat=body[3];

      const apiKey = "z5j34vkctqrq";
      //const userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUmF3YWQifQ.zY0MNdMd9huVSk_eIqfMvoYVGA0urn-hpwKPbafYrjg"; //should be sent by the server
      var userToken =userTokenChat;
      //should be sent by the server
      print("ddddddddddddddddddddddddd"+userToken);

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

      channel = client.channel('messaging', id: 'godevs');

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
