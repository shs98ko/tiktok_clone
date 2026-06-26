import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //Custom Scroll view: listview, gridview처럼 스크롤되는 뷰이지만 더 복잡한 요구사항들을 구현가능함
    return CustomScrollView(
      //slivers: customScrollView 안에 들어간 Element들이지만 모든 위젯을 넣을 수 있는 건 아님
      slivers: [
        SliverAppBar(
          floating: true,
          stretch: true,
          pinned: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
            ],
            background: Image.asset(
              "assets/images/test.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        ),
      ],
    );
  }
}
