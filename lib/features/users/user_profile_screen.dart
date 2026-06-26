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
    return const CustomScrollView();
  }
}
