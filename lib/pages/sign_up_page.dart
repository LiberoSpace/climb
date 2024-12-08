// import 'dart:convert';

// import 'package:climb/pages/sign_up_second_page.dart';
// import 'package:climb/styles/app_colors.dart';
// import 'package:climb/utils/check.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';

// enum NickNameInputStatus {
//   empty,
//   patternPossible,
//   patternImpossible,
//   duplicated,
//   possible,
// }

// enum BirthDayInputStatus {
//   empty,
//   possible,
//   patternImpossible,
// }

// enum GenderInputStatus {
//   empty,
//   man,
//   woman,
// }

// class SignUpPage extends StatefulWidget {
//   static String routerName = 'SignUp';

//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   NickNameInputStatus _nickNameInputStatus = NickNameInputStatus.empty;
//   BirthDayInputStatus _birthDayInputStatus = BirthDayInputStatus.empty;
//   GenderInputStatus _genderInputStatus = GenderInputStatus.empty;

//   final TextEditingController _nickNameEditingController =
//       TextEditingController();
//   final FocusNode _nickNameFocusNode = FocusNode();

//   final TextEditingController _birthDayEditingController =
//       TextEditingController();
//   final FocusNode _birthDayFocusNode = FocusNode();

//   final TextEditingController _heightEditingController =
//       TextEditingController();
//   final FocusNode _heightFocusNode = FocusNode();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _nickNameFocusNode.addListener(() {
//       if (!_nickNameFocusNode.hasFocus) {
//         _checkDuplicated(_nickNameEditingController.text);
//       }
//     });
//     _heightFocusNode.addListener(() {
//       if (!_heightFocusNode.hasFocus) {
//         translateTextToDoubleForm(_heightEditingController);
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _nickNameFocusNode.dispose();
//     _heightFocusNode.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const SizedBox(
//                     height: 32,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '로그인 해주셔서 감사합니다.',
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                           Text(
//                             '가입을 위한 필수 정보를 받을게요.',
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                           Text(
//                             '*필수로 입력해야 합니다.',
//                             style: Theme.of(context).textTheme.labelSmall,
//                           ),
//                         ],
//                       ),
//                       const Gap(36),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '닉네임 *',
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color: colorGray,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 height: 50,
//                                 padding: const EdgeInsets.all(12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         maxLength: 9,
//                                         focusNode: _nickNameFocusNode,
//                                         controller: _nickNameEditingController,
//                                         onChanged: (value) {
//                                           if (value == "") {
//                                             _nickNameInputStatus =
//                                                 NickNameInputStatus.empty;
//                                           } else if (checkNickNamePattern(
//                                               value)) {
//                                             _nickNameInputStatus =
//                                                 NickNameInputStatus
//                                                     .patternPossible;
//                                           } else {
//                                             _nickNameInputStatus =
//                                                 NickNameInputStatus
//                                                     .patternImpossible;
//                                           }
//                                           setState(() {});
//                                         },
//                                         onSubmitted: (value) =>
//                                             _checkDuplicated(value),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium,
//                                         decoration: InputDecoration(
//                                           hintText: "2~9 글자로 입력해주세요.",
//                                           hintStyle: Theme.of(context)
//                                               .textTheme
//                                               .labelMedium,
//                                           border: InputBorder.none,
//                                           counterText: '',
//                                           isDense: true,
//                                         ),
//                                         textAlignVertical:
//                                             TextAlignVertical.center,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 4,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               SizedBox(
//                                 height: 18,
//                                 child:
//                                     NickNameGuide(status: _nickNameInputStatus),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '생년월일 *',
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color: colorGray,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 height: 50,
//                                 padding: const EdgeInsets.all(12),
//                                 child: TextField(
//                                   maxLength: 8,
//                                   focusNode: _birthDayFocusNode,
//                                   keyboardType: TextInputType.number,
//                                   controller: _birthDayEditingController,
//                                   onChanged: (value) {
//                                     if (value == "") {
//                                       _birthDayInputStatus =
//                                           BirthDayInputStatus.empty;
//                                     } else if (checkBirthDayPattern(value)) {
//                                       _birthDayInputStatus =
//                                           BirthDayInputStatus.possible;
//                                     } else {
//                                       _birthDayInputStatus =
//                                           BirthDayInputStatus.patternImpossible;
//                                     }
//                                     setState(() {});
//                                   },
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                   decoration: InputDecoration(
//                                     hintText: "생년월일 8자리 (YYYYMMDD)",
//                                     hintStyle:
//                                         Theme.of(context).textTheme.labelMedium,
//                                     border: InputBorder.none,
//                                     counterText: '',
//                                     isDense: true,
//                                   ),
//                                   textAlignVertical: TextAlignVertical.center,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               SizedBox(
//                                 height: 18,
//                                 child: BirthDayGuide(
//                                   status: _birthDayInputStatus,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '성별 *',
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () {
//                                       if (_genderInputStatus ==
//                                           GenderInputStatus.man) {
//                                         _genderInputStatus =
//                                             GenderInputStatus.empty;
//                                       } else {
//                                         _genderInputStatus =
//                                             GenderInputStatus.man;
//                                       }
//                                       FocusScope.of(context).unfocus();
//                                       setState(() {});
//                                     },
//                                     style: ButtonStyle(
//                                       shape: WidgetStatePropertyAll(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             side: BorderSide(
//                                               color: _genderInputStatus ==
//                                                       GenderInputStatus.man
//                                                   ? colorOrange
//                                                   : colorGray,
//                                               width: 1,
//                                             )),
//                                       ),
//                                       padding: const WidgetStatePropertyAll(
//                                         EdgeInsets.symmetric(
//                                           horizontal: 40,
//                                           vertical: 16,
//                                         ),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       '남성',
//                                       style: _genderInputStatus ==
//                                               GenderInputStatus.man
//                                           ? Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                           : Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(color: colorGray),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 20),
//                                   TextButton(
//                                     onPressed: () {
//                                       if (_genderInputStatus ==
//                                           GenderInputStatus.woman) {
//                                         _genderInputStatus =
//                                             GenderInputStatus.empty;
//                                       } else {
//                                         _genderInputStatus =
//                                             GenderInputStatus.woman;
//                                       }
//                                       FocusScope.of(context).unfocus();
//                                       setState(() {});
//                                     },
//                                     style: ButtonStyle(
//                                       shape: WidgetStatePropertyAll(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             side: BorderSide(
//                                               color: _genderInputStatus ==
//                                                       GenderInputStatus.woman
//                                                   ? colorOrange
//                                                   : colorGray,
//                                               width: 1,
//                                             )),
//                                       ),
//                                       padding: const WidgetStatePropertyAll(
//                                         EdgeInsets.symmetric(
//                                           horizontal: 40,
//                                           vertical: 16,
//                                         ),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       '여성',
//                                       style: _genderInputStatus ==
//                                               GenderInputStatus.woman
//                                           ? Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                           : Theme.of(context)
//                                               .textTheme
//                                               .labelMedium
//                                               ?.copyWith(color: colorGray),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 40,
//                           ),
//                           Column(
//                             children: [
//                               Column(
//                                 children: [
//                                   SizedBox(
//                                     width: 200,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           '키(cm) *',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .titleMedium,
//                                         ),
//                                         Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             border: Border.all(
//                                               color: colorGray,
//                                               width: 1,
//                                             ),
//                                           ),
//                                           width: 100,
//                                           height: 36,
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 4,
//                                           ),
//                                           child: TextField(
//                                             maxLength: 5,
//                                             focusNode: _heightFocusNode,
//                                             keyboardType: const TextInputType
//                                                 .numberWithOptions(
//                                                 decimal: true),
//                                             onSubmitted: (value) {
//                                               translateTextToDoubleForm(
//                                                   _heightEditingController);
//                                               setState(() {});
//                                             },
//                                             controller:
//                                                 _heightEditingController,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyMedium,
//                                             decoration: InputDecoration(
//                                               hintText: "174.4",
//                                               hintStyle: Theme.of(context)
//                                                   .textTheme
//                                                   .labelMedium,
//                                               border: InputBorder.none,
//                                               counterText: '',
//                                               isDense: true,
//                                             ),
//                                             textAlignVertical:
//                                                 TextAlignVertical.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 52 + MediaQuery.of(context).size.height - 812,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: _canGoNext()
//                               ? () {
//                                   String nickName =
//                                       _nickNameEditingController.text;
//                                   DateTime birthDay = DateTime.parse(
//                                       _birthDayEditingController.text);
//                                   int gender = _genderInputStatus ==
//                                           GenderInputStatus.man
//                                       ? 1
//                                       : 2;
//                                   double height = double.parse(
//                                       _heightEditingController.text);
//                                   try {
//                                     context.pushNamed(
//                                       SignUpSecondPage.routerName,
//                                       extra: {
//                                         "nickName": nickName,
//                                         "birthDay": birthDay,
//                                         "gender": gender,
//                                         "height": height,
//                                       },
//                                     );
//                                   } catch (e) {
//                                     print(
//                                         'go next page error: ${jsonEncode(e)}');
//                                   }
//                                 }
//                               : null,
//                           style: ButtonStyle(
//                             alignment: Alignment.center,
//                             backgroundColor:
//                                 WidgetStateProperty.resolveWith((states) {
//                               if (states.contains(WidgetState.disabled)) {
//                                 return colorGray;
//                               }
//                               return colorOrange;
//                             }),
//                             shape: WidgetStatePropertyAll(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             padding: const WidgetStatePropertyAll(
//                               EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             '다음',
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _checkDuplicated(String nickName) {
//     try {
//       if (_nickNameInputStatus != NickNameInputStatus.patternPossible) {
//         return;
//       }
//       var userCollection =
//           FirebaseFirestore.instance.collection("user_profiles");
//       userCollection.where('nickName', isEqualTo: nickName).get().then(
//         (querySnapshot) {
//           if (querySnapshot.size > 0) {
//             _nickNameInputStatus = NickNameInputStatus.duplicated;
//           } else {
//             _nickNameInputStatus = NickNameInputStatus.possible;
//           }
//           setState(() {});
//         },
//       );
//     } catch (e) {
//       print('nickName duplicated check error: ${jsonEncode(e)}');
//     }
//   }

//   bool _canGoNext() {
//     if (_nickNameInputStatus == NickNameInputStatus.possible &&
//         _birthDayInputStatus == BirthDayInputStatus.possible &&
//         _genderInputStatus != GenderInputStatus.empty &&
//         _heightEditingController.text != '') {
//       return true;
//     }
//     return false;
//   }
// }

// class BirthDayGuide extends StatelessWidget {
//   final BirthDayInputStatus status;

//   const BirthDayGuide({
//     super.key,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (status == BirthDayInputStatus.empty ||
//         status == BirthDayInputStatus.possible) {
//       return const SizedBox.shrink();
//     } else {
//       return Text(
//         '8자리를 입력해주세요. (YYYYMMDD)',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: colorRed,
//             ),
//       );
//     }
//   }
// }

// class NickNameGuide extends StatelessWidget {
//   final NickNameInputStatus status;

//   const NickNameGuide({
//     super.key,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (status == NickNameInputStatus.empty) {
//       return const SizedBox.shrink();
//     } else if (status == NickNameInputStatus.patternPossible) {
//       return Text(
//         '',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: Colors.blue,
//             ),
//       );
//     } else if (status == NickNameInputStatus.possible) {
//       return Text(
//         '사용 가능한 닉네임입니다.',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: Colors.blue,
//             ),
//       );
//     } else if (status == NickNameInputStatus.patternImpossible) {
//       return Text(
//         '문자와 특수문자("_",".")로 2~9글자를 입력해주세요.',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: colorRed,
//             ),
//       );
//     } else {
//       return Text(
//         '이미 사용하고 있는 닉네임입니다.',
//         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               color: colorRed,
//             ),
//       );
//     }
//   }
// }
