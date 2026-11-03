import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/widgets/video_caption.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/features/videos/widgets/video_commu_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

//ConsumerStatefulWidget은 ref을 build 메소드 안에 있을 필요없다.
class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

// singleTickerProviderStateMixin: animation의 프레임마다 위젯이 화면에 보일 때만 tick하는 Ticker가 있는 클래스
class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  final Duration _animationDuration = Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isMuted = false;

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
      "assets/videos/test.mp4",
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // kIsWeb은 이 앱이 웹에서 작동하도록 compiile 되었는지를 나타내는 constant
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    if (!mounted) return;
    _isMuted = ref.read(playbackConfigProvider).muted;
    await _videoPlayerController.setVolume(_isMuted ? 0 : 1);

    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer(); //비디오를 재생시키려면 컨트롤러를 무조건 초기화시켜야 한다.
    _animationController = AnimationController(
      // vsync : 위젯이 위젯 tree에 있을 때만 Ticker를 유지하도록 animation 재생을 도와준다
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    //컨트롤러가 있다면 잊지말고 dispose해줘야한다 리소스 낭비를 방지하기 위해
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      final autoplay = ref.read(playbackConfigProvider).autoplay;
      if (autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _togglePause();
    }
  }

  void _togglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _togglePause();
    }
    await showModalBottomSheet(
      context: context,
      //bottom sheet안에서 list view를 사용한다면 높이 조절을 하기 위해 widget뿐만 아니라 sheet에도 설정해줘야 한다
      isScrollControlled: true,
      builder: (context) => VideoComments(),
    );
    _togglePause();
  }

  void _onMuteTap() async {
    _isMuted = !_isMuted;
    if (_isMuted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
    }
    setState(() {});
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    final muted = ref.read(playbackConfigProvider).muted;
    setState(() {
      _isMuted = muted;
    });

    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final videoConfig = context.dependOnInheritedWidgetOfExactType<VideoConfig>();
    // final videoConfig = VideoConfig.of(context);
    ref.listen<PlaybackConfigModel>(playbackConfigProvider, (previous, next) {
      _onPlaybackConfigChanged();
    });
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(child: GestureDetector(onTap: _togglePause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  //animationBuilder: animationController의 값이 변할 때 마다 실행됨
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@{widget.videoData.creator}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v8,
                Text(
                  widget.videoData.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                VideoCaption(
                  text:
                      "#googleearth, #googlemaps, #googleearth #googlemaps,#googleearth, #googlemaps ",
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _onMuteTap,
                  child: FaIcon(
                    _isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                ),
                Gaps.v24,
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/tiktok-abc-xyz.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                  ),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                VideoCommuButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "${widget.videoData.likes}",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoCommuButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "${widget.videoData.comments}",
                  ),
                ),
                Gaps.v24,
                VideoCommuButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
