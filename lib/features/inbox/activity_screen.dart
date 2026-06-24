import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notfications = List.generate(
    20,
    (index) => ("${index + 1}h"),
  );

  void _onDismissed(String notification) {
    _notfications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Activity")),
      body: ListView(
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
          for (var notification in _notfications)
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
                contentPadding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.bell, color: Colors.black),
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
    );
  }
}
