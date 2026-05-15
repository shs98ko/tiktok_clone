import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final FaIcon icon;
  final String text;
  const AuthButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox: 기본적으로 Box위젯인데 부모의 크기에 비례해서 크기를 정하게 해주는 위젯
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(width: Sizes.size1, color: Colors.grey.shade300),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Text(
              text,
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
