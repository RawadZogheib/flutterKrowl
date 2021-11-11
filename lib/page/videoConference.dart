import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/widgets/Buttons/IconButton.dart';
import 'package:flutter_ion/flutter_ion.dart' as ion;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uuid/uuid.dart';

ion.Constraints stts = ion.Constraints(
    resolution: 'hd',
    codec: 'vp8',
    audio: true,
    video: true,
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
  List<Participant> qlist = <Participant>[];

  // ion.Signal? _signal;
  String ServerURL = '';
  ion.Client? _client;
  ion.LocalStream? _localStream;
  //ion.LocalStream? _localStream2;
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

    pubSub();
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
    setState(() {
      plist.clear();
    });
    log("serverurl " + ServerURL);
    //if (_client == null) {
    // create new client
    _client =
        await ion.Client.create(sid: "test room", uid: _uuid, signal: _signal);

    // peer ontrack
    _client?.ontrack = (track, ion.RemoteStream remoteStream) async {
      if (track.kind == 'video') {
        print('ontrack: remote stream: ${remoteStream.stream}');
        var renderer = RTCVideoRenderer();
        await renderer.initialize();
        renderer.srcObject = remoteStream.stream;
        setState(() {
          plist.add(Participant('RemoteStream', renderer, remoteStream.stream));
        });
      }
    };

    _localStream = await ion.LocalStream.getUserMedia(constraints: stts);
    //_localStream2 = await ion.LocalStream.getUserMedia(constraints: stts);

    // publish the stream
    await _client?.publish(_localStream!);

    var renderer = RTCVideoRenderer();
    await renderer.initialize();
    renderer.srcObject = _localStream?.stream;
    setState(() {
      qlist.add(Participant("LocalStream", renderer, _localStream?.stream));
    });

    _localStream!.mute('audio');
    //_localStream!.mute('video');
    //_localStream2!.mute('video');
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
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
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

          Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: qlist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return getItemView(qlist[index]);
              },
            ),
          ),

          //voice/video/shareScreen
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyButton(
                      icon: iconMic,
                      onTap: () {
                        _setAudioButton();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyButton(
                      icon: videocam,
                      onTap: () {
                        _setVideoButton();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyButton(
                      icon: screen_share_outlined,
                      onTap: () async {
                        _setShareScreenButton();
                      }),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _setAudioButton() {
    //voice/video/shareScreen
    if (mic == true) {
      _localStream!.mute('audio');
      setState(() {
        iconMic = Icons.mic_off;
      });
      mic = !mic;
    } else if (mic == false) {
      _localStream!.unmute('audio');
      setState(() {
        iconMic = Icons.mic;
      });
      mic = !mic;
    }
  }

  _setVideoButton() {
    if (video == true) {
      _localStream!.mute('video');
      setState(() {
        videocam = Icons.videocam_off;
      });
      video = !video;
    } else if (video == false) {
      _localStream!.unmute('video');
      setState(() {
        videocam = Icons.videocam;
      });
      video = !video;
    }
  }

  _setShareScreenButton() {
    if (shareScreen == true) {
      setState(() {
        _localStream!.mute('video');
        screen_share_outlined = Icons.stop_screen_share_outlined;
      });
      shareScreen = !shareScreen;
    } else if (shareScreen == false) {
      setState(() {
        _localStream!.unmute('video');
        screen_share_outlined = Icons.screen_share_outlined;
      });
      shareScreen = !shareScreen;
    }
  }

  _back() async {
    // unPublish and remove stream from video element
    await _localStream?.stream.dispose();
    _localStream = null;
    _client?.close();
    _client = null;

    setState(() {
      plist.clear();
    });
    return true;
  }
}
