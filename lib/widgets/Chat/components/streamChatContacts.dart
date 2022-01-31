import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../TabBar/CustomTabBar.dart';

class StreamExampleTest extends StatelessWidget {
  final StreamChatClient client;

  // final Channel channel; // i added
  /// Minimal example using Stream's core Flutter package.
  ///
  /// If you'd prefer using pre-made UI widgets for your app, please see our
  /// other package, `stream_chat_flutter`.
  const StreamExampleTest({
    Key? key,
    required this.client,
    //required this.channel,
  }) : super(key: key);

  /// Instance of Stream Client.
  /// Stream's [StreamChatClient] can be used to connect to our servers and
  /// set the default user for the application. Performing these actions
  /// trigger a websocket connection allowing for real-time updates.

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
           body:HomeScreen()
          //   children: <Widget>[

              //CustomTabBar(),
              // SafeArea(
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Text(
              //           "Chats",
              //           style: TextStyle(
              //               fontSize: 30, fontWeight: FontWeight.bold),
              //         ),
              //         Container(
              //           padding: EdgeInsets.only(
              //               left: 8, right: 8, top: 2, bottom: 2),
              //           height: 30,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30),
              //             color: globals.blue2,
              //           ),
              //           child: Row(
              //             children: <Widget>[
              //               Icon(
              //                 Icons.add,
              //                 color: globals.blue1,
              //                 size: 20,
              //               ),
              //               SizedBox(
              //                 width: 2,
              //               ),
              //               Text(
              //                 "New",
              //                 style: TextStyle(
              //                     fontSize: 14, fontWeight: FontWeight.bold),
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: "Search...",
              //       hintStyle: TextStyle(color: Colors.grey.shade400),
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.grey.shade400,
              //         size: 20,
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey.shade100,
              //       contentPadding: EdgeInsets.all(8),
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: BorderSide(color: Colors.grey.shade100)),
              //     ),
              //   ),
              // ),


          ),
        builder: (context, child) => StreamChatCore(
          client: client,
          child: child!,
        ),
      );
}

/// Basic layout displaying a list of [Channel]s the user is a part of.
/// This is implemented using [ChannelListCore].
///
/// [ChannelListCore] is a `builder` with callbacks for constructing UIs based
/// on different scenarios.
class HomeScreen extends StatelessWidget {
  /// Builds a basic layout displaying a list of [Channel]s the user is a
  /// part of.
  HomeScreen({Key? key}) : super(key: key);

  /// Controller used for loading more data and controlling pagination in
  /// [ChannelListCore].
  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) => Scaffold(
        // body: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //     CustomTabBar(),
        // SafeArea(
        //   child: Padding(
        //     padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Text(
        //           "Chats",
        //           style:
        //           TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //         ),
        //         Container(
        //           padding:
        //           EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        //           height: 30,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(30),
        //             color: globals.blue2,
        //           ),
        //           child: Row(
        //             children: <Widget>[
        //               Icon(
        //                 Icons.add,
        //                 color: globals.blue1,
        //                 size: 20,
        //               ),
        //               SizedBox(
        //                 width: 2,
        //               ),
        //               Text(
        //                 "New",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       hintText: "Search...",
        //       hintStyle: TextStyle(color: Colors.grey.shade400),
        //       prefixIcon: Icon(
        //         Icons.search,
        //         color: Colors.grey.shade400,
        //         size: 20,
        //       ),
        //       filled: true,
        //       fillColor: Colors.grey.shade100,
        //       contentPadding: EdgeInsets.all(8),
        //       enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(30),
        //           borderSide: BorderSide(color: Colors.grey.shade100)),
        //     ),
        //   ),
        // ),
    appBar: AppBar(
      title: const Text('Contacts'),
    ),
        body: ChannelsBloc(
          child: ChannelListCore(
            channelListController: channelListController,
            filter: Filter.and([
              Filter.equal('type', 'messaging'),
              Filter.in_(
                'members',
                [
                  StreamChatCore.of(context).currentUser!.id,
                ],
              )
            ]),
            emptyBuilder: (BuildContext context) => const Center(
              child: Text('Looks like you are not in any channels'),
            ),
            loadingBuilder: (BuildContext context) => const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
            errorBuilder: (
              BuildContext context,
              dynamic error,
            ) =>
                Center(
              child: Text(
                'Oh no, something went wrong. '
                'Please check your config. $error',
              ),
            ),
            listBuilder: (
              BuildContext context,
              List<Channel> channels,
            ) =>
                LazyLoadScrollView(
              onEndOfPage: () async {
                channelListController.paginateData!();
              },
              child: ListView.builder(
                itemCount: channels.length,
                itemBuilder: (BuildContext context, int index) {
                  final _item = channels[index];
                  return ListTile(
                    title: Text(_item.name ?? ''),
                    subtitle: StreamBuilder<Message?>(
                      stream: _item.state!.lastMessageStream,
                      initialData: _item.state!.lastMessage,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.text!);
                        }

                        return const SizedBox();
                      },
                    ),
                    onTap: () {
                      /// Display a list of messages when the user taps on
                      /// an item. We can use [StreamChannel] to wrap our
                      /// [MessageScreen] screen with the selected channel.
                      ///
                      /// This allows us to use a built-in inherited widget
                      /// for accessing our `channel` later on.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StreamChannel(
                            channel: _item,
                            child: const MessageScreen(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

}

/// A list of messages sent in the current channel.
/// When a user taps on a channel in [HomeScreen], a navigator push
/// [MessageScreen] to display the list of messages in the selected channel.
///
/// This is implemented using [MessageListCore], a convenience builder with
/// callbacks for building UIs based on different api results.
class MessageScreen extends StatefulWidget {
  /// Build a MessageScreen
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  final messageListController = MessageListController();

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

  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// To access the current channel, we can use the `.of()` method on
    /// [StreamChannel] to fetch the closest instance.
    final channel = StreamChannel.of(context).channel;
    return Scaffold(
      appBar: AppBar(
        title: Text(channel.name.toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LazyLoadScrollView(
                onEndOfPage: () async {
                  messageListController.paginateData!();
                },
                child: MessageListCore(
                  messageListController: messageListController,
                  emptyBuilder: (BuildContext context) => const Center(
                    child: Text('Nothing here yet'),
                  ),
                  loadingBuilder: (BuildContext context) => const Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  messageListBuilder: (
                    BuildContext context,
                    List<Message> messages,
                  ) =>
                      ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      final item = messages[index];
                      final client = StreamChatCore.of(context).client;
                      if (item.user!.id == client.uid) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(item.text!),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(item.text!),
                          ),
                        );
                      }
                    },
                  ),
                  errorBuilder: (BuildContext context, error) {
                    print(error.toString());
                    return const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child:
                            Text('Oh no, an error occured. Please see logs.'),
                      ),
                    );
                  },
                ),
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
                        if (_controller.value.text.isNotEmpty) {
                          await channel.sendMessage(
                            Message(text: _controller.value.text),
                          );
                          if (mounted) {
                            _controller.clear();
                            _updateList();
                          }
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extensions can be used to add functionality to the SDK. In the example
/// below, we add a simple extensions to the [StreamChatClient].
extension on StreamChatClient {
  /// Fetches the current user id.
  String get uid => state.currentUser!.id;
}