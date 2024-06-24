import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget1 extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget1({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState1 createState() => _VideoPlayerWidgetState1();
}

class _VideoPlayerWidgetState1 extends State<VideoPlayerWidget1> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    height: 350,
                    width: 500,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        // VideoProgressIndicator(_controller, allowScrubbing: true),
      ],
    );
  }
}
