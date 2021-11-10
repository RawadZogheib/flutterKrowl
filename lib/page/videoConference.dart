import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Buttons/IconButton.dart';
import 'package:flutter_ion/flutter_ion.dart' as ion;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uuid/uuid.dart';


ion.Constraints video = ion.Constraints(
    resolution: 'hd',
    codec: 'vp8',
    audio: true,
    video: true,
    simulcast: false);

ion.Constraints onlyVideo = ion.Constraints(
    resolution: 'hd',
    codec: 'vp8',
    audio: false,
    video: true,
    simulcast: false);

ion.Constraints audio = ion.Constraints(
    resolution: 'hd',
    codec: 'vp8',
    audio: true,
    video: false,
    simulcast: false);

class VideoConference extends StatefulWidget {
  VideoConference({Key? key}) : super(key: key);

  @override
  _VideoConferenceState createState() => _VideoConferenceState();
}

class Participant {
  Participant(this.title, this.renderer, this.stream);

  MediaStream? stream;
  String title;
  RTCVideoRenderer renderer;
}

class _VideoConferenceState extends State<VideoConference> {
  List<Participant> plist = <Participant>[];

  // ion.Signal? _signal;
  String ServerURL = '';
  ion.Client? _client;
  ion.LocalStream? _localStream;
  final String _uuid = Uuid().v4();

  var iconMic = Icons.mic_off;
  var videocam = Icons.videocam_off;
  var screen_share_outlined = Icons.stop_screen_share_outlined;

  bool mic = false; //video/onlyVideo/voice/shareScreen
  bool video = false;
  bool shareScreen = false;

  @override
  void initState() {
    super.initState();
    initSignal();
  }

  initSignal() {
    if (kIsWeb) {
      //ServerURL = 'http://localhost:9090';
      ServerURL = 'http://147.78.45.13:9090';
    } else {
      ServerURL = 'http://147.78.45.13:9090';
      //ServerURL = 'http://10.10.4.64:9090';
    }
  }

  late ion.Signal _signal = ion.GRPCWebSignal(ServerURL);

  void pubSub() async {
    log("serverurl " + ServerURL);
    if (_client == null) {
      // create new client
      _client = await ion.Client.create(
          sid: "test room", uid: _uuid, signal: _signal);

      // peer ontrack
      _client?.ontrack = (track, ion.RemoteStream remoteStream) async {
        if (track.kind == 'video') {
          print('ontrack: remote stream: ${remoteStream.stream}');
          var renderer = RTCVideoRenderer();
          await renderer.initialize();
          renderer.srcObject = remoteStream.stream;
          setState(() {
            plist.add(
                Participant('RemoteStream', renderer, remoteStream.stream));
          });
        }
      };

      _localStream = await ion.LocalStream.getUserMedia(
          constraints: audio);

      // publish the stream
      await _client?.publish(_localStream!);

      var renderer = RTCVideoRenderer();
      await renderer.initialize();
      renderer.srcObject = _localStream?.stream;
      setState(() {
        plist.add(Participant("LocalStream", renderer, _localStream?.stream));
      });
    } else {

      // // unPublish and remove stream from video element
      // await _localStream?.stream.dispose();
      // _localStream = null;
      // _client?.close();
      // _client = null;
      //
      // setState(() {
      //   plist.clear();
      // });
    }
  }

  Widget getItemView(Participant item) {
    log("items: " + item.toString());
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${item.title}:\n${item.stream!.id}',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            Expanded(
              child: RTCVideoView(item.renderer,
                  objectFit:
                      RTCVideoViewObjectFit.RTCVideoViewObjectFitContain),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: plist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return getItemView(plist[index]);
            },
          ),
        ),

        //voice/video/shareScreen
        SizedBox(
          height: 800,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyButton(
                    icon: iconMic,
                    onTap: () {
                      mic = !mic;
                      _setButtons();

                      pubSub();

                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyButton(
                    icon: videocam,
                    onTap: () {
                      video = !video;
                      _setButtons();

                      _endCall();
                      //pubSub();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyButton(
                    icon: screen_share_outlined,
                    onTap: () async {
                      shareScreen = !shareScreen;
                      _setButtons();

                        audio..video = true;

                        _localStream = await ion.LocalStream.getUserMedia(
                            constraints: audio);

                        // publish the stream
                        await _client?.publish(_localStream!);

                        var renderer = RTCVideoRenderer();
                        await renderer.initialize();
                        renderer.srcObject = _localStream?.stream;
                        setState(() {
                        plist.add(Participant("LocalStream", renderer, _localStream?.stream));
                        });


                      //pubSub();
                    }),
              ),
            ],
          ),
        )
      ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: pubSub,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.video_call),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _setButtons() {
    //voice/video/shareScreen
    if (mic == true) {
      setState(() {
        iconMic = Icons.mic;
      });
    } else if (mic == false) {
      setState(() {
        iconMic = Icons.mic_off;
      });
    }
    if (video == true) {
      setState(() {
        videocam = Icons.videocam;
      });
    } else if (video == false) {
      setState(() {
        videocam = Icons.videocam_off;
      });
    }
    if (shareScreen == true) {
      setState(() {
        screen_share_outlined = Icons.screen_share_outlined;
      });
    } else if (shareScreen == false) {
      setState(() {
        screen_share_outlined = Icons.stop_screen_share_outlined;
      });
    }
  }

  _endCall() async {
    // unPublish and remove stream from video element
    print("tt1");
    await _localStream?.stream.dispose();
    _localStream = null;
    _client?.close();
    _client = null;
    print("tt2");

    //plist.clear();
  }
}
