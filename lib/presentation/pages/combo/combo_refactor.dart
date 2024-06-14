import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void _showWarning(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Size not selected"),
        content:
            const Text("Please select a size before checking the checkbox."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

class ComboAddedItems extends StatelessWidget {
  const ComboAddedItems({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return text == "Not applicable"
        ? RichText(
            text: TextSpan(children: [
            title == "Size"
                ? TextSpan()
                : TextSpan(
                    text: "$title: ",
                    style: const TextStyle(color: Colors.black)),
            title == "Size"
                ? TextSpan()
                : TextSpan(
                    text: text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5)),
          ]))
        : RichText(
            text: TextSpan(children: [
            TextSpan(
                text: "$title: ", style: const TextStyle(color: Colors.black)),
            TextSpan(
                text: text,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5)),
          ]));
  }
}

class VideoWidget extends StatelessWidget {
  final String url;

  const VideoWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(url: url);
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
