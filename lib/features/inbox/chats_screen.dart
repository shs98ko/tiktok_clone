import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static String routeName = "chats";
  static String routeURL = "/chats";

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _item = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _item.length,
        duration: Duration(milliseconds: 400),
      );
      _item.add(_item.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) =>
            Container(color: Colors.red, child: _makeTile(index)),
      );
      _item.removeAt(index);
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(ChatDetailScreen.routeName, params: {"chatId": "$index"});
    // context.push("${ChatsScreen.routeURL}/$index");
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => ChatDetailScreen()));
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
          "https://avatars.githubusercontent.com/u/3612017",
        ),
        child: Text("Nico"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Nico($index)", style: TextStyle(fontWeight: FontWeight.w600)),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: Text("Say hi to AntonioBM"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Messages"),
        actions: [
          IconButton(onPressed: _addItem, icon: FaIcon(FontAwesomeIcons.plus)),
        ],
      ),
      //AnimationList로도 listveiw.builder와 listTile의 기능을 똑같이 사용가능하고
      //리스트의 아이템들을 animate해준다. 아이템이 실시간으로 반영될 때 유용함
      //또한 itemcount가 없어 key를 추가하여 메서드를 활용하여 item을 추가한다.
      body: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: Key('$index'),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
