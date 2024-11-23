import 'package:climb/pages/exercise_records_page.dart';
import 'package:climb/pages/sing_in_page.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static String routerName = 'Splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final UserAuthProvider _userAuthProvider;

  @override
  void initState() {
    super.initState();
    _userAuthProvider = context.read<UserAuthProvider>();

    Future.delayed(const Duration(milliseconds: 500), () async {
      await _checkSignedIn();
    });
  }

  Future<void> _checkSignedIn() async {
    User? user = _userAuthProvider.user;
    if (user != null) {
      await _userAuthProvider.refreshUserByFirestore();
      if (mounted) {
        if (_userAuthProvider.appUser == null ||
            _userAuthProvider.userProfile == null) {
          await _userAuthProvider.signOut(context);
          return;
        }
        context.goNamed(ExerciseRecordsPage.routerName);
        return;
      }
    }
    if (mounted) {
      context.goNamed(SingInPage.routerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -0.1),
        child: ClipOval(
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            'assets/logos/climb_logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
