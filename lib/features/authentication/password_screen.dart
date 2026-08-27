import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/view_moedels/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordVaild() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onScffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordVaild()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BirthdayScreen()));
  }

  void _onCleatTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScffoldTap,
      child: Scaffold(
        appBar: AppBar(title: Text("Sign up")),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                'Create password',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                onEditingComplete:
                    _onSubmit, // onSubmitted(입력값을 모를 때) / onEditingComplete
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  // 위젯: prefix, suffix / 아이콘: prefixIcon, suffixIcon
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onCleatTap,
                        child: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          size: Sizes.size16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.h14,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: Sizes.size16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  hintText: "Make it strong!",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              Gaps.v6,
              Text(
                "Your password must have:",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v6,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordVaild() ? Colors.green : Colors.grey,
                  ),
                  Gaps.h4,
                  Text(
                    "8 to 20 characters",
                    style: TextStyle(fontSize: Sizes.size12),
                  ),
                ],
              ),
              Gaps.v24,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  buttonText: "Next",
                  disabled: !_isPasswordVaild(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
