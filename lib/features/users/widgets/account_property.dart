import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AccountProperty extends StatelessWidget {
  final String number;
  final String title;
  const AccountProperty({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.size18),
        ),
        Text(title, style: TextStyle(color: Colors.grey.shade500)),
      ],
    );
  }
}
