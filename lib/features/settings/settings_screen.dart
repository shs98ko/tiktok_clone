import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/view_moedels/signout_view_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
//다른 로직으로 옮겨야 됨
// bool _notification = false;

// void _onNotificationChanged(bool? newValue) {
//   if (newValue == null) return;
//   setState(() {
//     _notification = newValue;
//   });
// }
class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setMuted(value),
            },
            title: const Text("Mute video"),
            subtitle: const Text("Video will be muted by default."),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setAutoplay(value),
            },
            title: const Text("Autoplay"),
            subtitle: const Text("Video will start playing automatically."),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) => {},
            title: Text("Enable Notification"),
            subtitle: const Text("They will be cute."),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) => {},
            title: Text("Marketing Emails"),
            subtitle: const Text("We won't spam you."),
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        ref.read(signOutProvieder.notifier).signOut();
                        context.go("/");
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (iOS / bottom)"),
            textColor: Colors.red,
            onTap: () {
              //showCupertinoModalPopup과 showCupertinoModal은 바깥 영역을 클릭한다면 뒤로가기 버튼기능을 한다.
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  message: const Text("Please dooooont gooooo"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              print(date);
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(booking);
            },

            title: Text("What is your birthday?"),
            subtitle: Text("I need to know!"),
          ),
          AboutListTile(
            applicationVersion: "1.0",
            applicationLegalese: "Don't copy me.",
          ),
          //showAboutDialog 을 바로 ListTile로 사용할 수 있는 aboutListTile 위젯이 있다.
        ],
      ),
    );
  }
}
