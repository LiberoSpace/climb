import 'package:flutter/material.dart';

class OnboardingDialog extends StatelessWidget {
  Widget widget;

  OnboardingDialog({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: widget,
    );
  }
}
