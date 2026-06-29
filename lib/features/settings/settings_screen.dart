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
          ),
          AboutListTile(),
          //showAboutDialog 을 바로 ListTile로 사용할 수 있는 aboutListTile 위젯이 있다.
        ],
      ),
    );
  }
}
