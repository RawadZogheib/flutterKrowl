import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/page/Chat.dart';
import 'package:stream_chat/stream_chat.dart';

import '../widgets/Chat/modules/chat_page.dart';

class MainChat extends StatelessWidget {
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
    const apiKey = "z5j34vkctqrq";
    const userToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUmF3YWQifQ.zY0MNdMd9huVSk_eIqfMvoYVGA0urn-hpwKPbafYrjg"; //should be sent by the server

    client = StreamChatClient(apiKey, logLevel: Level.INFO);

    await client.connectUser(
      User(
        id: 'Rawad',
        //name: 'Cool Shadow',
        // image:
        // 'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
      ),
      userToken,
    );

    channel = client.channel('messaging', id: 'godevs');

    await channel.watch();
  }
}
