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

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(offstage: _selectedIndex != 0, child: StfScreen()),
          Offstage(offstage: _selectedIndex != 1, child: StfScreen()),
          Offstage(offstage: _selectedIndex != 3, child: StfScreen()),
          Offstage(offstage: _selectedIndex != 4, child: StfScreen()),
          /*
          다른 navigation tab으로 갔다 원래 tab으로 돌아온 경우 선택된 인덱스만 보여주고 선택되지 않은 것들은 없어지기 때문에 처음부터 다시 빌드된다
          처음부터 다시 시작하지 않기 위해 모든 화면을 그리긴 하지만 보이지는 않게, 즉 사용자에게 시각적으로 보이지 않게 한다 
          이로인해 사용자의 족적을 파악할 수 있다
          -> Offstage를 활용한다 기본값은 offstage: true라면 화면에 보이지 않는다 단 너무 많은 resource를 사용하지 않게 해야한다 
          */
        ],
      ),
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
