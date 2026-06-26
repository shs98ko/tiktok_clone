import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

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
      //Sliver는 스크롤가능한 구역

      //slivers: customScrollView 안에 들어간 Element들이지만 모든 위젯을 넣을 수 있는 건 아님
      slivers: [
        SliverAppBar(
          stretch: true,

          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            background: Image.asset(
              "assets/images/test.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        ),

        //SliverToBoxAdapter: CustomSrollView에 모든 위젯을 넣을수 있는 방법이다
        SliverToBoxAdapter(
          child: Column(
            children: [CircleAvatar(backgroundColor: Colors.red, radius: 20)],
          ),
        ),

        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100,
        ),

        //slivarPersistentHeader는 delegate를 상속받은 클래스로 설정해야 동작된다.
        SliverPersistentHeader(delegate: CustomDelgate(), floating: true),

        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}

class CustomDelgate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.blue,
      //    FractionallySizedBox : 부모로부터 최대한 많은 공간을 차지함
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text("Grid Title!!!", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  //    shouldRebuild는 darkmode section에서 다룬다
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
