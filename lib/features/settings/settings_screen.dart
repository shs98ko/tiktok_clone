import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      /*
        Closebutton : x모양의 버튼을 렌더링하는 위젯
        ListWheelScrollView : 리스트 애니메이션 뷰
        CuoertinoActivityIndicator : ios 로딩 위젯
        CircularProgressIndicator : 안드로이드 로딩 위젯
        CirclularProgressIndicator.adaptive
          -  android / web => android 로딩
          -  ios => ios 로딩
      */
      body: ListView(
        children: [
          // ListTile(
          //   onTap: () => showAboutDialog(
          //     context: context,
          //     applicationVersion: "1.0",
          //     applicationLegalese: "All rights reserved. Please don't copy me",
          //   ),
          //   title: Text("About", style: TextStyle(fontWeight: FontWeight.w600)),
          //   subtitle: Text("About this app..."),
          // ),
          AboutListTile(),
          //showAboutDialog 을 바로 LisTile로 사용할 수 있는 aboutListTile 위젯이 있다.
        ],
      ),
    );
  }
}
