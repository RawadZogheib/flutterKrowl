import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  tmpname=_item.state!.members.first.userId; //getting the userid which is the username of the first member
                  if(tmpname !=null){
                    res=tmpname?.compareTo(_item.client.uid);
                    if(res==0){
                      chname=_item.state!.members.last.userId; //first member
                    }else{
                      chname=tmpname;
                    }
                  }


                  return ListTile(
                    title: Text(chname ?? ''),
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
    tmpname=channel.state!.members.first.userId; //getting the userid which is the username of the first member
    if(tmpname !=null){
      res=tmpname?.compareTo(channel.client.uid);
      if(res==0){
        chname=channel.state!.members.last.userId; //first member
      }else{
        chname=tmpname;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(chname ?? ''),
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
