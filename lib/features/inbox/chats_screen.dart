import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Messages"),
        actions: [
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.plus)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: Sizes.size10),
        children: [
          ListTile(
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
                Text("Nico", style: TextStyle(fontWeight: FontWeight.w600)),
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
          ),
        ],
      ),
    );
  }
}
