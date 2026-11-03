import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return;
    // _pageController.nextPage(duration: _duration, curve: _curve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(timelineProvider)
        .when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text("Could not load Videos : $error")),
          data: (videos) => RefreshIndicator(
            onRefresh: _onRefresh,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final videoData = videos[index];
                return VideoPost(
                  onVideoFinished: _onVideoFinished,
                  index: index,
                  videoData: videoData,
                );
              },
            ),
          ),
        );
  }
}
