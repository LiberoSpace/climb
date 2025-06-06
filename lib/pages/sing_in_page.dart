// import 'dart:io';

// import 'package:climb/pages/exercise_records_page.dart';
// import 'package:climb/pages/sign_up_page.dart';
// import 'package:climb/styles/app_colors.dart';
// import 'package:climb/constants/config.dart';
// import 'package:climb/providers/user_auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class SingInPage extends StatelessWidget {
//   static String routerName = 'SingIn';

//   const SingInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userAuthProvider = Provider.of<UserAuthProvider>(context);

//     afterSignIn(int result) {
//       if (result == 0) {
//         return;
//       } else if (result == 1) {
//         context.goNamed(ExerciseRecordsPage.routerName);
//         return;
//       } else if (result == 2) {
//         context.goNamed(SignUpPage.routerName);
//         return;
//       }
//     }

//     return Scaffold(
//       body: Padding(
//         padding: paddingAllPage,
//         child: SafeArea(
//           child: Align(
//             alignment: const Alignment(0, -0.1),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Column(
//                   children: [
//                     ClipOval(
//                       child: SvgPicture.asset(
//                         'assets/logos/climb_logo.svg',
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Gap(80),
//                 TextButton(
//                   onPressed: () {
//                     userAuthProvider.handleSignIn(AuthPlatForm.kakao).then(
//                           (result) => afterSignIn(result),
//                         );
//                   },
//                   style: ButtonStyle(
//                     alignment: Alignment.center,
//                     backgroundColor: const WidgetStatePropertyAll(
//                       Color(0xffFEE500),
//                     ),
//                     shape: WidgetStatePropertyAll(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           8.0,
//                         ),
//                       ),
//                     ),
//                     padding: const WidgetStatePropertyAll(
//                       EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/logos/kakao_logo.png',
//                         height: 24,
//                         width: 24,
//                       ),
//                       const Gap(12),
//                       Text(
//                         '카카오로 로그인',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Gap(16),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         userAuthProvider.handleSignIn(AuthPlatForm.google).then(
//                               (result) => afterSignIn(result),
//                             );
//                       },
//                       style: ButtonStyle(
//                         alignment: Alignment.center,
//                         backgroundColor: const WidgetStatePropertyAll(
//                           Color(0xffFFFFFF),
//                         ),
//                         shape: WidgetStatePropertyAll(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                               8.0,
//                             ),
//                             side: const BorderSide(
//                               color: Color(0xff000000),
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                         padding: const WidgetStatePropertyAll(
//                           EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 12,
//                           ),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/logos/google_logo.png',
//                             height: 24,
//                             width: 24,
//                           ),
//                           const Gap(12),
//                           Text(
//                             '구글로 로그인',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (Platform.isIOS) const Gap(16),
//                     if (Platform.isIOS)
//                       TextButton(
//                         onPressed: () {
//                           userAuthProvider
//                               .handleSignIn(AuthPlatForm.apple)
//                               .then(
//                                 (result) => afterSignIn(result),
//                               );
//                         },
//                         style: ButtonStyle(
//                           overlayColor: WidgetStatePropertyAll(
//                             const Color(0xffFFFFFF).withOpacity(0.15),
//                           ),
//                           alignment: Alignment.center,
//                           backgroundColor: const WidgetStatePropertyAll(
//                             Color(0xff000000),
//                           ),
//                           shape: WidgetStatePropertyAll(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                 8.0,
//                               ),
//                             ),
//                           ),
//                           padding: const WidgetStatePropertyAll(
//                             EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 12,
//                             ),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/logos/apple_logo.png',
//                               height: 24,
//                               width: 24,
//                               color: const Color(0xffFFFFFF),
//                             ),
//                             const Gap(12),
//                             Text(
//                               '애플로 로그인',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .copyWith(color: const Color(0xffFFFFFF)),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
