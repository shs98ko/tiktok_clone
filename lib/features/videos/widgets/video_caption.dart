import 'package:flutter/material.dart';

class VideoCaption extends StatefulWidget {
  final String text;
  const VideoCaption({super.key, required this.text});

  @override
  State<VideoCaption> createState() => _VideoCaptionState();
}

class _VideoCaptionState extends State<VideoCaption> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            maxLines: _isExpanded ? null : 1, // 펼치면 null (제한없음)
            overflow: _isExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: _toggleExpanded,
          child: Text(
            _isExpanded ? "Close" : "See more",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
