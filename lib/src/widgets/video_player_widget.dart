import 'package:flutter/material.dart';
import 'package:practica2/src/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoMovieModel? trailer;
  VideoPlayerWidget({Key? key, this.trailer}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  late String _videoKey = "9HTWDnKs6hA";

  @override
  void initState() {
    // TODO: implement initState
    if(widget.trailer!=null){
      _videoKey = widget.trailer!.key!;
    }
    _controller = YoutubePlayerController(
      initialVideoId: _videoKey,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener(){
    if(_isPlayerReady && mounted && !_controller.value.isFullScreen){
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        print('Player is ready.');
      },
    ), 
    builder: (context, player)=>Center(
      child: player,
    ));
  }
}