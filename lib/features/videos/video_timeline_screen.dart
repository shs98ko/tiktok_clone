import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  //스크롤링할 때 애니메이션 차이로 인해 앱이 느려지기 때문에 애니메이션을 커스텀한다.
  //-> controller은 builder 바깥에 있고, widget을 컨트롤할 수 있다.
  final PageController _pageController = PageController();

  int _itemCount = 4;

  final Duration _duration = Duration(microseconds: 250);
  final Curve _curve = Curves.linear;

  void _onPageChanged(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: _duration,
      curve: _curve,
    );
    if (pageIndex == _itemCount - 1) {
      _itemCount += 4;
    }
    setState(() {});
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: _duration, curve: _curve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished),
    );
  }
}
