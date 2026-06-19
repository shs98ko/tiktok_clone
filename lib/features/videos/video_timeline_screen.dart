import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  List<Color> colors = [Colors.blue, Colors.amber, Colors.yellow, Colors.teal];

  void _onPageChanged(int pageIndex) {
    if (pageIndex == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([Colors.blue, Colors.amber, Colors.yellow, Colors.teal]);
      //addAll : 한 리스트에 있는 모든 항목들을 다른 리스트에 추가한다.
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      //listView.builder와 마찬가지로 데이터를 한번에 불러오는 것이 아닌 필요할 때 불러온다.
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      //onPageChanged: 유저가 이동할 때 도착하는 페이지에 대한 정보를 주는 메소드
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text("Screen page $index", style: TextStyle(fontSize: 68)),
        ),
      ),
    );
  }
}
