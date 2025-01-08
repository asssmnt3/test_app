import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YouTubeScreen(
        videoUrls: [
          'https://youtu.be/U0svrc0TDQM?si=xUh6aKNNQC4KpWR-',
          'https://youtu.be/H6-6vb6yDYE?si=2agMGJrv_Q8uoEM1',
          'https://youtu.be/vhpH3681yvw?si=oPAWF54yxN1NkUH0',
        ],
      ),
    );
  }
}

class YouTubeScreen extends StatefulWidget {
  final List<String> videoUrls;

  const YouTubeScreen({Key? key, required this.videoUrls}) : super(key: key);

  @override
  _YouTubeScreenState createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen> {
  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each video URL
    _controllers = widget.videoUrls.map((url) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      if (videoId != null) {
        return YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      } else {
        return YoutubePlayerController(
          initialVideoId: '',
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ); // Handle invalid URL gracefully
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YouTube Videos"),
      ),
      body: ListView.builder(
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    onReady: () {
                      // Optionally handle video readiness
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          controller.play();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: () {
                          controller.pause();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: () {
                          controller.seekTo(const Duration(seconds: 0));
                          controller.pause();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
