import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoFlashButton extends StatelessWidget {
  final Future<void> Function(FlashMode) setFlashMode;
  final IconData icon;
  final FlashMode currentFlashMode;
  final FlashMode newFlashMode;
  const VideoFlashButton({
    super.key,
    required this.icon,
    required this.setFlashMode,
    required this.currentFlashMode,
    required this.newFlashMode,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setFlashMode(newFlashMode),
      icon: Icon(
        icon,
        size: Sizes.size36,
        color: currentFlashMode == newFlashMode
            ? Colors.amber.shade200
            : Colors.white,
      ),
    );
  }
}
