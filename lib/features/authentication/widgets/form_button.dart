import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({super.key, required this.disabled});

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: Sizes.size12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size2),
          color: disabled
              ? Colors.grey.shade200
              : Theme.of(context).primaryColor,
        ),
        duration: Duration(milliseconds: 300),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            color: disabled ? Colors.grey : Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w500,
          ),
          child: Text("Next", textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
