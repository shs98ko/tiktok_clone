import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  //앱을 실행하기 전에 state를 어떤 식으로든 바꾸고 싶다면 bind, widget과 engine을 initialize하고 연결을 해야한다.
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //어디서든 사용가능하다.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'TikTok clone',
      themeMode: ThemeMode.system, //themeMode : 핸드폰한테 어떤 theme을 사용할지 알려주는 기능
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFFE9435A),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomAppBarTheme: BottomAppBarThemeData(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      //모든 디자인, color, background등 같은 것들은 themeData에서 설정해주고 필요시 isDarkMode로 설정해주는 것이 좋다.
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xFFE9435A),
        bottomAppBarTheme: BottomAppBarThemeData(
          color: Colors.grey.shade900,
          elevation: 0,
        ),
      ),
    );
  }
}

//Media Query: 현재 내 앱을 사용하고 있는 기기에 대한 정보를 준다 (화면크기, 밝기, 다크모드 여부, 방향, 높이, padding)
//Layout builder : 화면크기가 아닌 box의 최대 크기를 알기 위해 사용함 또한 부모의 크기를 알고 싶을 때, 부모의 크기에 따라 변경하고 싶을 때 유용하다
//  boxConstraints는 box가 커질 수 있는 최대치
/*
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                "${size.width} / ${constraints.maxWidth}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
