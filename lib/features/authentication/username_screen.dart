import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  static String routeURL = "username";
  static String routeName = "username";
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  //매개변수 context 필요없음; statefulwidget의 state 내부라면 어디서든 context를 사용가능하다
  void onEmailTap() {
    if (_username.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EmailScreen(username: _username)),
    );
    // Navigator.pushNamed(
    //   context,
    //   EmailScreen.routeName,
    //   arguments: EmailScreenArgs(username: _username),
    // );
    //Navigator.of(context).pushNamed로 라우팅된 화면 정보 보내는법
    //  - arguments를 이용한다
    /* context.pushNamed(
      EmailScreen.routeName,
      extra: EmailScreenArgs(username: _username),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            const Text(
              'Create username',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v5,
            const Text(
              'You can always change this later.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
                fontWeight: FontWeight.w300,
              ),
            ),
            Gaps.v20,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            Gaps.v24,
            GestureDetector(
              onTap: onEmailTap,
              child: FormButton(
                buttonText: "Next",
                disabled: _username.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
