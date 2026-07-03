import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/utils.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextfieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void onNextTap() {
    context.pushReplacementNamed(InterestsScreen.routeName);
    // context.goNamed(InterestsScreen.routeName);
    //push는 다른화면 맨 위에 새로운 화면을 올리는 것 -> 뒤로 가기 가능
    //다른 모든 화면의 기록들을 삭제후 push하기 ->  뒤로 가기 할 수 없음 / 뒤에 있는 화면을 선택해서 삭제 가능
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => InterestsScreen()),
    // (route) => true,  // 모든 route를 유지
    //   (route) => false, // 이전 route를 제거
    // );
  }

  void _setTextfieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
              'When\'s your birthday?',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v5,
            Opacity(
              opacity: 0.7,
              child: const Text(
                'Your birthday won\'t be shown publicly',
                style: TextStyle(
                  fontSize: Sizes.size16,

                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Gaps.v20,
            TextField(
              enabled: false,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
              controller: _birthdayController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
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
              onTap: onNextTap,
              child: FormButton(buttonText: "Next", disabled: false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 250,
        child: SizedBox(
          child: CupertinoDatePicker(
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextfieldDate,
          ),
        ),
      ),
    );
  }
}
