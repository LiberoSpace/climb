import 'package:climb/pages/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static String routerName = 'Splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // late final UserAuthProvider _userAuthProvider;

  @override
  void initState() {
    super.initState();
    // _userAuthProvider = context.read<UserAuthProvider>();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.goNamed(CameraPage.routerName);
      }
    });
    // Future.delayed(const Duration(milliseconds: 500), () async {
    //   await _checkSignedIn();
    // });
  }

  // Future<void> _checkSignedIn() async {
  //   User? user = _userAuthProvider.user;
  //   if (user != null) {
  //     await _userAuthProvider.refreshUserByFirestore();
  //     if (mounted) {
  //       if (_userAuthProvider.appUser == null ||
  //           _userAuthProvider.userProfile == null) {
  //         await _userAuthProvider.signOut(context);
  //         return;
  //       }
  //       context.goNamed(ExerciseRecordsPage.routerName);
  //       return;
  //     }
  //   }
  //   if (mounted) {
  //     context.goNamed(CameraPage.routerName);
  //   }
  // }

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
