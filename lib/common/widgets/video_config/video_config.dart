import 'package:flutter/widgets.dart';

//inheritedWidget: 위젯 최상위 트리에서 정의된 값도 접근할 수 있다
//primaryColor 지정과 같은 논리다

/*
1. 위젯을 현 최상단위젯을 감싸서 최상단트리로 만들어줘서 state를 접근할 수 있게하고
2. context를 사용하여 inheritedWidget에 직접적인 링크 요청을 한다.
3. of 생성자를 이용하여 .of(context)를 이용한다.
*/

// inheritWidget은 데이터는 제공하지만 연결된 위젯에서 수정할수 없다 -> 나중에 changeNotifier를 이용한다
// VideoConfigData는 데이터통로라고 보면 된다.
class VideoConfigData extends InheritedWidget {
  final bool autoMute;
  final void Function() toggleMuted;

  const VideoConfigData({
    super.key,
    required super.child,
    required this.toggleMuted,
    required this.autoMute,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  //updateShouldNotify: inherit위젯을 rebuild할지 말지 정할 수 있게 해준다.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({super.key, required this.child});

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      toggleMuted: toggleMuted,
      autoMute: autoMute,
      child: widget.child,
    );
  }
}
