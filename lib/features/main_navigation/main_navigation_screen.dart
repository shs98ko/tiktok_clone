import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/main_navigation/sth_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    //navigation을 통해 들어간 모든 화면을 똑같은 화면을 만들었다면 globalKey로 서로 다른 위젯인 것 처럼 렌더링 해줄 수 있다.
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
    Container(),
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
    //다른 navigation tab으로 갔다 원래 tab으로 돌아온 경우 선택된 인덱스만 보여주고 선택되지 않은 것들은 삭제되기 때문에 처음부터 다시 빌드된다
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: screens[_selectedIndex],
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              text: 'Home',
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              isSelected: _selectedIndex == 0,
              onTap: () => _onTap(0),
            ),
            NavTab(
              text: 'Discover',
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
            ),
            NavTab(
              text: 'Inbox',
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              isSelected: _selectedIndex == 3,
              onTap: () => _onTap(3),
            ),
            NavTab(
              text: 'Profile',
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              isSelected: _selectedIndex == 4,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
