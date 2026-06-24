import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(
    20,
    (index) => ("${index + 1}h"),
  );
  final List<Map<String, dynamic>> _tabs = [
    {"title": "All activity", "icon": FontAwesomeIcons.solidMessage},
    {"title": "Likes", "icon": FontAwesomeIcons.solidHeart},
    {"title": "Comments", "icon": FontAwesomeIcons.solidComments},
    {"title": "Mentions", "icon": FontAwesomeIcons.at},
    {"title": "Followers", "icon": FontAwesomeIcons.solidUser},
    {"title": "From TikTok", "icon": FontAwesomeIcons.tiktok},
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );

  // 애니메이션 보여주는 2가지 방법
  // 1. AnimationController의 value를 수정하고 Controller에 enventListener를 추가하고 setState를 하면 그게 build메소드를 실행시키고 사용자에게 애니메이션을 보여진다.
  // 2. Animation Builder를 사용하여 1번방식을 대신 해준다.
  // 이코드는 animation을 사용하면서도 2가지 방법을 사용하지 않아도 된다.

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: Offset(0, -1), //이때 숫자는 비율이다.
    end: Offset(0, 0),
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_arrowAnimation.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("All Activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: FaIcon(FontAwesomeIcons.chevronDown, size: Sizes.size14),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                //dismissible : 모드위젯을 감쌀 수 있고, 좌우로 밀어내서 위젯을 사라지게 할 수 있다.
                Dismissible(
                  //onDismissed는 direction매개변수를 통해 오른쪽, 왼쪽에서 밀어냈는 지 알 수 있다.
                  onDismissed: (direction) => _onDismissed(notification),
                  key: Key(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.only(left: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(right: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),

                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Sizes.size12,
                    ),
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //RichText: text들을 나열에 각각 설정가능하다.
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: Sizes.size16,
                        ),
                        children: [
                          TextSpan(
                            text: " Upload longer videos",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: " $notification",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            //AnimatedModalBarrier: 패널 뒤에 있는 오버레이를 말그대로 팝업(modal)의 장벽으로 이부분을 어둡게하여 일어나는 모든 이벤트를 무시하도록 만들어주는 위젯
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size2),
                  bottomRight: Radius.circular(Sizes.size2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
