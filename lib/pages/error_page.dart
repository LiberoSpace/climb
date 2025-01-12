import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  static String routerName = 'Error';

  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('에러입니다.'),
      ),
    );
  }
}
