import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:climb/firebase_options.dart';
import 'package:climb/providers/camera_provider.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/styles/app_fonts.dart';
import 'package:climb/routes.dart';
import 'package:climb/database/database.dart';
import 'package:climb/database_services/climbing_problem_service.dart';
import 'package:climb/database_services/difficulty_service.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/location_service.dart';
import 'package:climb/database_services/video_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  const env = String.fromEnvironment('FLUTTER_APP_FLAVOR');

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  if (env.contains('-prod')) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
  }

  // font
  GoogleFonts.config.allowRuntimeFetching = false;

  // Set portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // if (kDebugMode || kProfileMode) {
  //   print('debug or profile mode');
  //   // debug 모드 설정
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
  //   );
  // } else {
  //   await FirebaseAppCheck.instance.activate();

  //   FlutterError.onError = (errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   };

  //   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // }
  await FirebaseAppCheck.instance.activate();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final database = AppDatabase();
  final prefs = await SharedPreferences.getInstance();
  final appDocDir = await getApplicationDocumentsDirectory();

  final allCameras = await availableCameras();

  runApp(
    App(
      prefs: prefs,
      appDocDir: appDocDir,
      allCameras: allCameras,
      database: database,
    ),
  );
}

class App extends StatelessWidget {
  final SharedPreferences prefs;
  final Directory appDocDir;
  final List<CameraDescription> allCameras;
  final AppDatabase database;

  App(
      {super.key,
      required this.prefs,
      required this.database,
      required this.appDocDir,
      required this.allCameras});

  final _firebaseFirestore = FirebaseFirestore.instance;

  copyDifficulty(String uid, QuerySnapshot querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      var difficulties = docSnapshot.data() as Map<String, dynamic>;
      _firebaseFirestore
          .collection("/locations/$uid/difficulties")
          .add(difficulties)
          .then((DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    // var difficultiesRef = _firebaseFirestore
    //     .collection("/locations/tcGsgs6ilwx2j4M8lYP1/difficulties");

    // difficultiesRef.get().then((querySnapshot) {
    //   copyDifficulty('tIcc0VwJcpWQI7S3qIrC', querySnapshot);
    //   copyDifficulty('rZQJOWrpkHMpAcizNFdl', querySnapshot);
    //   copyDifficulty('p91tiz4VsaCmHJ1h9ivC', querySnapshot);
    //   copyDifficulty('loWBSI8GH5b7wInHueWb', querySnapshot);
    //   copyDifficulty(x'gbdJKPlTklha8Y2DDLdX', querySnapshot);
    //   copyDifficulty('c4XIyZ1ZOp4Si5aayG5t', querySnapshot);
    //   copyDifficulty('bhb03XLcgA05oHHpVQcA', querySnapshot);
    //   copyDifficulty('LY89ebxp05Wl9NfeCzL3', querySnapshot);
    //   copyDifficulty('1FtGV3uMz4UGe4bvUs5C', querySnapshot);
    //   copyDifficulty('048iBUdtrpsdThOJkjPW', querySnapshot);
    // });

    /** image picker가 메모리를 정리했을 경우에 앱을 다시 키고 가져와야 함. */
    //   Future<void> getLostData() async {
    //   final ImagePicker picker = ImagePicker();
    //   final LostDataResponse response = await picker.retrieveLostData();
    //   if (response.isEmpty) {
    //     return;
    //   }
    //   final List<XFile>? files = response.files;
    //   if (files != null) {
    //     _handleLostFiles(files);
    //   } else {
    //     _handleError(response.exception);
    //   }
    // }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthProvider>(
          create: (_) => UserAuthProvider(
              auth: FirebaseAuth.instance,
              prefs: prefs,
              firestore: _firebaseFirestore,
              firebaseStorage: FirebaseStorage.instance,
              appDocDir: appDocDir),
        ),
        Provider<AppDirectoryProvider>(
          create: (context) => AppDirectoryProvider(
            appDocDir: appDocDir,
          ),
        ),
        Provider<CameraProvider>(
          create: (context) => CameraProvider(
            allCameras: allCameras,
          ),
        ),
        ChangeNotifierProvider<ExerciseRecordModel>(
          create: (context) => ExerciseRecordModel(db: database),
        ),
        Provider<ClimbingProblemService>(
          create: (context) => ClimbingProblemService(db: database),
        ),
        Provider<VideoService>(
          create: (context) => VideoService(db: database),
        ),
        Provider<LocationService>(
          create: (context) => LocationService(db: database),
        ),
        Provider<DifficultyService>(
          create: (context) => DifficultyService(db: database),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: false,
            titleTextStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorBlack,
              ),
            ),
            scrolledUnderElevation: 0,
            toolbarTextStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorBlack,
              ),
            ),
            iconTheme: const IconThemeData(size: 24),
            actionsIconTheme: const IconThemeData(size: 24),
          ),
          textTheme: climbTextTheme,
          dividerTheme: const DividerThemeData(
            color: colorLightGray,
            space: 1,
          ),
        ),
        routerConfig: CustomRouter.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
