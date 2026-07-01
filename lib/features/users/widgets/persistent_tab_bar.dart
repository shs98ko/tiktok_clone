import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
            width: 0.1,
          ),
        ),
      ),
      child: TabBar(
        splashFactory: NoSplash.splashFactory,
        labelPadding: EdgeInsets.symmetric(vertical: Sizes.size10),

        dividerColor: Colors.transparent,
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: FaIcon(FontAwesomeIcons.gripVertical),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 46.2;

  @override
  double get minExtent => 46.2;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
