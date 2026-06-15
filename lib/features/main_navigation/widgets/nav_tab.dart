import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final IconData selectedIcon;

  const NavTab({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              // ? column에 min설정을 하지않으면 기본적으로 어떤 위젯이 없다면 세로축의 최대한 공간을 차지하게됨?
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(isSelected ? selectedIcon : icon, color: Colors.white),
                Gaps.v5,
                Text(text, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
