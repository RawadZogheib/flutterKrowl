import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/globals/globals.dart' as globals;
import 'package:flutter_app_backend/widgets/Chat/components/chat_detail_page_appbar.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

String? chname;
String? tmpname;
int? res;

class StreamExampleTest extends StatelessWidget {
  final StreamChatClient client;

  //final Channel channel; // i added
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
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeScreen()),
        builder: (context, child) => StreamChatCore(
          client: client,
          child: child!,
        ),
      );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Chats",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: globals.blue1,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: globals.blue2,
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
            ],
          ),
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
                  tmpname = _item.state!.members.first
                      .userId; //getting the userid which is the username of the first member
                  if (tmpname != null) {
                    res = tmpname?.compareTo(_item.client.uid);
                    if (res == 0) {
                      chname = _item.state!.members.last.userId; //first member
                    } else {
                      chname = tmpname;
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StreamChannel(
                            channel: _item,
                            child: const MessageScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('Assets/UserImage1.jpeg'),
                                  maxRadius: 30,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(chname ?? ''),
                                        // This is the username
                                        SizedBox(
                                          height: 6,
                                        ),
                                        StreamBuilder<Message?>(
                                          stream:
                                              _item.state!.lastMessageStream,
                                          initialData: _item.state!.lastMessage,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(snapshot.data!.text!);
                                            }

                                            return const SizedBox();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   widget.time,
                          //   style: TextStyle(
                          //       fontSize: 12,
                          //       color: widget.isMessageRead
                          //           ? Colors.blue.shade900
                          //           : Colors.grey.shade500),
                          // ),
                          StreamBuilder<ChannelState?>(
                            stream:
                            _item.state!.channelStateStream,
                            initialData: _item.state!.channelState,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.channel!.lastMessageAt!.toLocal().day.toString()+"/"+snapshot.data!.channel!.lastMessageAt!.toLocal().month.toString()
                                    +"/"+snapshot.data!.channel!.lastMessageAt!.toLocal().year.toString()+"  @ "+snapshot.data!.channel!.lastMessageAt!.toLocal().hour.toString()+
                                    ":"+snapshot.data!.channel!.lastMessageAt!.toLocal().minute.toString());
                              }

                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                  // title: Text(chname ?? ''),
                  // subtitle: StreamBuilder<Message?>(
                  //   stream: _item.state!.lastMessageStream,
                  //   initialData: _item.state!.lastMessage,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Text(snapshot.data!.text!);
                  //     }
                  //
                  //     return const SizedBox();
                  //   },
                  // ),
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
    var statusUser;
    tmpname = channel.state!.members.first
        .userId; //getting the userid which is the username of the first member
    if (tmpname != null) {
      res = tmpname?.compareTo(channel.client.uid);
      if (res == 0) {
        chname = channel.state!.members.last.userId; //first member
        statusUser= channel.state!.members.last.user!.online;
      } else {
        chname = tmpname;
        statusUser= channel.state!.members.first.user!.online;
      }
      if(statusUser==true){
        statusUser="online";
      }else{
        statusUser="offline";
      }
    }
    return Scaffold(
      appBar: ChatDetailPageAppBar(
        username: chname ?? '',
        status:statusUser,
      ),
      // appBar: AppBar(
      //   title: Text(chname ?? ''),
      //   backgroundColor: Colors.transparent,
      //   shadowColor: Colors.transparent,
      // ),
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
                        return Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 10, bottom: 10),
                          child: Align(
                            alignment: (Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: (Colors.grey.shade200),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(item.text!),
                            ),
                          ),
                        );
                        // child: Text(item.text!, style: TextStyle(color: Colors.red),),

                      } else {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 10, bottom: 10),
                          child: Align(
                            alignment: (Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: (Colors.white),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(item.text!),
                            ),
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 16, bottom: 10),
                height: 80,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "Type message...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(right: 20),
                      child: FloatingActionButton(
                        onPressed: () async {
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
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue.shade900,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Container(
            //     width: 40,
            //     height: 40,
            //     margin: EdgeInsets.only(right: 20, bottom: 25),
            //     child: FloatingActionButton(
            //       onPressed: () async {
            //         if (_controller.value.text.isNotEmpty) {
            //           await channel.sendMessage(
            //             Message(text: _controller.value.text),
            //           );
            //           if (mounted) {
            //             _controller.clear();
            //             _updateList();
            //           }
            //         }
            //       },
            //       child: Icon(
            //         Icons.send,
            //         color: Colors.white,
            //       ),
            //       backgroundColor: Colors.blue.shade900,
            //       elevation: 0,
            //     ),
            //   ),
            // )
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: _controller,
            //           decoration: const InputDecoration(
            //             hintText: 'Enter your message',
            //           ),
            //         ),
            //       ),
            //       Material(
            //         type: MaterialType.circle,
            //         color: Colors.blue,
            //         clipBehavior: Clip.hardEdge,
            //         child: InkWell(
            //           onTap: () async {
            //             if (_controller.value.text.isNotEmpty) {
            //               await channel.sendMessage(
            //                 Message(text: _controller.value.text),
            //               );
            //               if (mounted) {
            //                 _controller.clear();
            //                 _updateList();
            //               }
            //             }
            //           },
            //           child: const Padding(
            //             padding: EdgeInsets.all(8),
            //             child: Center(
            //               child: Icon(
            //                 Icons.send,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
