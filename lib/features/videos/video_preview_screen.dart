import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isPicked;
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _isSaved = false;

  Future<void> _onSaveToGallery() async {
    if (_isSaved) return;
    await SaverGallery.saveFile(
      filePath: widget.video.path,
      fileName: "TikTok Clone!",
      skipIfExists: false,
    );
    _isSaved = true;

    setState(() {});
  }

  Future<void> _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _onSaveToGallery,
              icon: FaIcon(
                _isSaved ? FontAwesomeIcons.check : FontAwesomeIcons.download,
              ),
            ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
