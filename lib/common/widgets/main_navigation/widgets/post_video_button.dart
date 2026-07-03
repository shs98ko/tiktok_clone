import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PostVideoButton extends StatelessWidget {
  final int selectedIndex;
  const PostVideoButton({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Stack(
      clipBehavior: Clip.none, // stack안에 있는 element가 stack의 범위를 넘어갈 수 있게 한다
      children: [
        //Positioned widget: stack내부의 element를 이동시킴(단 stack안에서 기준이 있어야함)
        Positioned(
          right: Sizes.size16,
          child: Container(
            width: 25,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size16,
          child: Container(
            width: 25,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: Sizes.size11),
          decoration: BoxDecoration(
            color: selectedIndex == 0 || isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: selectedIndex == 0 || isDark ? Colors.black : Colors.white,
              size: Sizes.size16 + Sizes.size2,
            ),
          ),
        ),
      ],
    );
  }
}
