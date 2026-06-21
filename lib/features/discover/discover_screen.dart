import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping"];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Discover"),
          //bottom : preferredSizeWidget => 위젯 자체는 특정사이즈를 가지려고 하지만 그 위젯 안의 자식요소가 부모요소의 크기제한을 받지 않는다
          bottom: TabBar(
            padding: EdgeInsets.only(left: 0),
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            tabs: [for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [
            for (var tab in tabs)
              Center(child: Text(tab, style: TextStyle(fontSize: 28))),
          ],
        ),
      ),
    );
  }
}
