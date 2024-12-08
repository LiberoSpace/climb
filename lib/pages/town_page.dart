// import 'package:climb/database_services/exercise_record_service.dart';
// import 'package:climb/providers/user_auth_provider.dart';
// import 'package:drift_db_viewer/drift_db_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TownPage extends StatefulWidget {
//   static String routerName = 'Town';

//   const TownPage({super.key});

//   @override
//   State<TownPage> createState() => _TownPageState();
// }

// class _TownPageState extends State<TownPage> {
//   late ExerciseRecordModel _exerciseRecordModel;
//   late final UserAuthProvider _userAuthProvider =
//       context.read<UserAuthProvider>();

//   @override
//   void initState() {
//     super.initState();
//     _exerciseRecordModel = context.read<ExerciseRecordModel>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           '홈',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) =>
//                             DriftDbViewer(_exerciseRecordModel.db)));
//                   },
//                   child: const Text('DB viewer'),
//                 ),
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     await _userAuthProvider.signOut(context);
//                   },
//                   child: const Text('로그아웃'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
