import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthPlatForm { google, kakao, apple, email }

enum SignInResult { fail, signIn, signUp }

class UserAuthProvider extends ChangeNotifier {
  final FirebaseAuth auth;
  final SharedPreferences prefs;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final Directory appDocDir;

  late int totalVideoCount;
  late int totalContentSizeMb;
  late ResolutionPreset cameraResolution;

  User? _user;
  User? get user => _user;

  // AppUser? _appUser;
  // AppUser? get appUser => _appUser;

  // UserProfile? _userProfile;
  // UserProfile? get userProfile => _userProfile;

  UserAuthProvider({
    required this.auth,
    required this.prefs,
    required this.firestore,
    required this.firebaseStorage,
    required this.appDocDir,
  }) {
    totalVideoCount = prefs.getInt('totalVideoCount') ?? 0;
    totalContentSizeMb = prefs.getInt('totalContentSizeMb') ?? 0;
    cameraResolution = prefs.getInt('resolution') != null
        ? ResolutionPreset.values[prefs.getInt('resolution')!]
        : ResolutionPreset.veryHigh;

    // auth.authStateChanges().listen((User? user) {
    //   _user = user;
    //   if (_user == null) {
    //     _appUser = null;
    //     _userProfile = null;
    //   }
    //   notifyListeners();
    // });
  }

  // Future<int> handleSignIn(AuthPlatForm authPlatForm) async {
  //   late UserCredential userCredential;

  //   // 종류별 SignIn처리
  //   if (authPlatForm == AuthPlatForm.google) {
  //     userCredential = await _signInWithGoogle();
  //   } else if (authPlatForm == AuthPlatForm.apple) {
  //     userCredential = await _signInWithApple();
  //   } else {
  //     throw Exception(['error sign in platform']);
  //   }

  //   if (userCredential.user != null) {
  //     // 신규 가입
  //     if (userCredential.additionalUserInfo?.isNewUser == true) {
  //       return 2;
  //     }

  //     // 이전 유저이면 정보 조회 후 유저정보 있는지 확인
  //     await refreshUserByFirestore();
  //     if (appUser == null || userProfile == null) {
  //       return 2;
  //     }

  //     return 1;
  //   }
  //   return 0;
  // }

  // Future<bool> signUp({
  //   required String nickName,
  //   required DateTime birthDay,
  //   required int gender,
  //   required double height,
  //   String? profileIntroduction,
  //   required int profileDifficultyIndex,
  //   double? armReach,
  //   double? weight,
  // }) async {
  //   try {
  //     if (_user == null) {
  //       return false;
  //     }
  //     var email = _user!.email;
  //     if (_user!.providerData[0].providerId == 'apple.com') {
  //       if (_user!.providerData[0].email == null) {
  //         Fluttertoast.showToast(msg: '이메일이 없습니다. 문의해주세요');
  //         return false;
  //       }

  //       email = _user!.providerData[0].email;
  //     } else if (email == null) {
  //       Fluttertoast.showToast(msg: '이메일이 없습니다. 문의해주세요');
  //       return false;
  //     }
  //     var uid = _user!.uid;

  //     // firestore에 정보 최종 저장
  //     await Future.wait([
  //       _createAppUser(
  //           AppUser(
  //             birthDay: birthDay,
  //             gender: gender,
  //             email: email!,
  //             weight: weight,
  //           ),
  //           uid),
  //       _createUserProfile(
  //           UserProfile(
  //             nickName: nickName,
  //             profileDifficultyIndex: profileDifficultyIndex,
  //             height: height,
  //             armReach: armReach,
  //             profileIntroduction: profileIntroduction,
  //           ),
  //           uid),
  //     ]);

  //     return true;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<void> signOut(BuildContext context) async {
  //   try {
  //     context.goNamed(SingInPage.routerName);

  //     await Future.delayed(const Duration(milliseconds: 300), () async {
  //       await auth.signOut();
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<UserCredential> _signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       Fluttertoast.showToast(msg: "Sign in fail");
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     return userCredential;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<UserCredential> _signInWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   appleProvider.addScope('email');
  //   if (kIsWeb) {
  //     return await FirebaseAuth.instance.signInWithPopup(appleProvider);
  //   } else {
  //     return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  //   }
  // }

  // Future<void> _createUserProfile(UserProfile userProfile, String uid) async {
  //   await firestore
  //       .collection("user_profiles")
  //       .doc(uid)
  //       .withConverter(
  //         fromFirestore: UserProfile.fromFirestore,
  //         toFirestore: (UserProfile userProfile, _) =>
  //             userProfile.toFirestore(),
  //       )
  //       .set(userProfile);

  //   _userProfile = userProfile;
  //   notifyListeners();
  // }

  // Future<void> updateUserProfile(UserProfile userProfile, String uid) async {
  //   if (userProfile.profileImg != null) {
  //     await _uploadMyProfileImage(userProfile.profileImg!);
  //   }

  //   await firestore
  //       .collection("user_profiles")
  //       .doc(uid)
  //       .withConverter(
  //         fromFirestore: UserProfile.fromFirestore,
  //         toFirestore: (UserProfile userProfile, _) =>
  //             userProfile.toFirestore(),
  //       )
  //       .set(userProfile);

  //   _userProfile = userProfile;
  //   notifyListeners();
  // }

  // Future<void> _createAppUser(AppUser appUser, String uid) async {
  //   await firestore
  //       .collection("users")
  //       .doc(uid)
  //       .withConverter(
  //         fromFirestore: AppUser.fromFirestore,
  //         toFirestore: (AppUser appUser, _) => appUser.toFirestore(),
  //       )
  //       .set(appUser);

  //   _appUser = appUser;
  //   notifyListeners();
  // }

  // Future<void> updateAppUser(AppUser appUser, String uid) async {
  //   await firestore
  //       .collection("users")
  //       .doc(uid)
  //       .withConverter(
  //         fromFirestore: AppUser.fromFirestore,
  //         toFirestore: (AppUser appUser, _) => appUser.toFirestore(),
  //       )
  //       .set(appUser);

  //   _appUser = appUser;
  //   notifyListeners();
  // }

  // Future<void> refreshUserByFirestore() async {
  //   try {
  //     if (user == null) {
  //       return;
  //     }
  //     var uid = user!.uid;
  //     var profileDocRef =
  //         firestore.collection("user_profiles").doc(uid).withConverter(
  //               fromFirestore: UserProfile.fromFirestore,
  //               toFirestore: (UserProfile userProfile, _) =>
  //                   userProfile.toFirestore(),
  //             );
  //     var userDocRef = firestore.collection("users").doc(uid).withConverter(
  //           fromFirestore: AppUser.fromFirestore,
  //           toFirestore: (AppUser appUser, _) => appUser.toFirestore(),
  //         );

  //     var userProfileDocSnapshot = await profileDocRef.get();
  //     var userDocSnapshot = await userDocRef.get();

  //     _userProfile = userProfileDocSnapshot.data();

  //     await _downloadMyProfileImage();
  //     _appUser = userDocSnapshot.data();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _downloadMyProfileImage() async {
  //   try {
  //     final storageRef = firebaseStorage
  //         .ref()
  //         .child("profiles/${user!.uid}/profileImage.jpeg");
  //     final dirPath = "${appDocDir.path}/my";
  //     final filePath = "$dirPath/profileImage.jpeg";
  //     final file = File(filePath);

  //     // 디렉터리가 없으면 생성
  //     final directory = Directory(dirPath);
  //     if (!directory.existsSync()) {
  //       await directory.create(recursive: true);
  //     }

  //     await storageRef.writeToFile(file);
  //     userProfile?.profileImg = file.readAsBytesSync();
  //     notifyListeners();
  //   } on FirebaseException catch (e) {
  //     if (e.code != 'object-not-found') {
  //       rethrow;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // _uploadMyProfileImage(Uint8List image) async {
  //   try {
  //     // storage에 업로드
  //     final profileImageRef = firebaseStorage
  //         .ref()
  //         .child("profiles/${user!.uid}/profileImage.jpeg");
  //     await profileImageRef.putData(image);

  //     // 로컬에 저장
  //     final dirPath = "${appDocDir.path}/my";
  //     final filePath = "$dirPath/profileImage.jpeg";
  //     final file = File(filePath);
  //     file.writeAsBytesSync(image);

  //     // 객체에 저장
  //     userProfile?.profileImg = image;
  //     notifyListeners();
  //   } on FirebaseException catch (e) {
  //     print(e);
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  updateVideoCountAndTotalSize(int videoDataSizeMB) async {
    try {
      var count = prefs.getInt('totalVideoCount') ?? 0; // 처음 사용 시 기본값 0
      var sizeMb = prefs.getInt('totalContentSizeMb') ?? 0; // 처음 사용 시 기본값 0

      await Future.wait([
        prefs.setInt('totalVideoCount', count + 1),
        prefs.setInt('totalContentSizeMb', sizeMb + videoDataSizeMB),
      ]);

      totalVideoCount = prefs.getInt('totalVideoCount') ?? 0;
      totalContentSizeMb = prefs.getInt('totalContentSizeMb') ?? 0;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  updateResolution(ResolutionPreset resolutionPreset) async {
    try {
      await prefs.setInt('resolution', resolutionPreset.index);
      cameraResolution = resolutionPreset;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Future<UserCredential> signInWithKakao() async {}
  // Future<UserCredential> signInWithApple() async {}
}

// class UserProfile {
//   String nickName;
//   double height;
//   int profileDifficultyIndex;
//   String? profileIntroduction;
//   double? armReach;
//   Uint8List? profileImg;

//   UserProfile({
//     required this.nickName,
//     required this.height,
//     required this.profileDifficultyIndex,
//     this.armReach,
//     this.profileIntroduction,
//     this.profileImg,
//   });

//   factory UserProfile.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data();
//     return UserProfile(
//       nickName: data?['nickName'],
//       height: data?['height'],
//       profileDifficultyIndex: data?['profileDifficultyIndex'],
//       armReach: data?['armReach'],
//       profileIntroduction: data?['profileIntroduction'],
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       "nickName": nickName,
//       "height": height,
//       "profileDifficultyIndex": profileDifficultyIndex,
//       if (armReach != null) "armReach": armReach,
//       if (profileIntroduction != null)
//         "profileIntroduction": profileIntroduction,
//     };
//   }
// }

// class AppUser {
//   String email;
//   int gender;
//   DateTime birthDay;
//   double? weight;

//   AppUser({
//     required this.email,
//     required this.gender,
//     required this.birthDay,
//     required this.weight,
//   });

//   factory AppUser.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data();
//     return AppUser(
//       email: data?['email'],
//       gender: data?['gender'],
//       birthDay: (data?['birthDay'] as Timestamp).toDate(),
//       weight: data?['weight'],
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       "email": email,
//       "gender": gender,
//       "birthDay": birthDay,
//       if (weight != null) "weight": weight,
//     };
//   }
// }
