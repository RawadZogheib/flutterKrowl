import 'dart:convert';

import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter/material.dart';
import "package:stream_chat/stream_chat.dart";
import 'package:flutter_app_backend/globals/globals.dart' as globals;

// class StreamExample extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: 'Stream Chat Dart Example',
//     home: HomeScreen(channel: channel, name: name,),
//   );
// }

/// Main screen of our application. The layout is comprised of an [AppBar]
/// containing the channel name and a [MessageView] displaying recent messages.
class StreamExample extends StatefulWidget {
  String name;
  /// Instance of [StreamChatClient] we created earlier.
  /// This contains information about our application and connection state.
  final StreamChatClient client;
  /// The channel we'd like to observe and participate.
  final Channel channel;

  /// To initialize this example, an instance of
  /// [client] and [channel] is required.
  StreamExample({
    Key? key,
    required this.name,
    required this.client,
    required this.channel,
  }) : super(key: key);
  

  @override
  State<StreamExample> createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  @override
  Widget build(BuildContext context) {
    final messages = widget.channel.state!.messagesStream;
    return WillPopScope(
          onWillPop: () async => _back(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    _back();
                  }),
            ),
            body: SafeArea(
              child: StreamBuilder<List<Message>?>(
                stream: messages,
                builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Message>?> snapshot,
                    ) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return MessageView(
                      messages: snapshot.data!.reversed.toList(),
                      channel: widget.channel,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'There was an error loading messages. Please see logs.',
                      ),
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
  }

  _back() {
    setState(() {
      widget.channel.dispose();
    });
    Navigator.of(context).pop();
  }
}

/// UI used to display a list of recent messages and a [TextField] for sending
/// new messages.
class MessageView extends StatefulWidget {
  /// Message takes the latest list of messages and the current channel.
  const MessageView({
    Key? key,
    required this.messages,
    required this.channel,
  }) : super(key: key);

  /// List of messages sent in the given channel.
  final List<Message> messages;

  /// Current channel being observed.
  final Channel channel;

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  List<Message> get _messages => widget.messages;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Convenience method for scrolling the list view when a new message is sent.
  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _messages.length,
          reverse: true,
          itemBuilder: (BuildContext context, int index) {
            final item = _messages[index];
            if (item.user?.id == widget.channel.client.uid) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.text ?? ''),
                ),
              );
            } else {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.text ?? ''),
                ),
              );
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter your message',
                ),
              ),
            ),
            Material(
              type: MaterialType.circle,
              color: Colors.blue,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () async {
                  // We can send a new message by calling `sendMessage` on
                  // the current channel. After sending a message, the
                  // TextField is cleared and the list view is scrolled
                  // to show the new item.
                  if (_controller.value.text.isNotEmpty) {
                    await widget.channel.sendMessage(
                      Message(text: _controller.value.text),
                    );
                    _controller.clear();
                    _updateList();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}

/// Helper extension for quickly retrieving
/// the current user id from a [StreamChatClient].
extension on StreamChatClient {
  String get uid => state.currentUser!.id;
}
