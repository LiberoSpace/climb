import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/database/database.dart';
import 'package:climb/database_services/climbing_problem_service.dart';
import 'package:climb/database_services/difficulty_service.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/error_page.dart';
import 'package:climb/pages/exercise_record_detail_page.dart';
import 'package:climb/pages/exercise_records_page.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/providers/camera_provider.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/utils/get_file_size.dart';
import 'package:climb/widgets/dialogs/confirmation_dialog.dart';
import 'package:climb/widgets/dialogs/location_search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_thumbnail;
import 'package:wakelock_plus/wakelock_plus.dart';

class CameraPage extends StatefulWidget {
  static String routerName = 'Camera';

  const CameraPage({
    super.key,
  });

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraProvider _cameraProvider;

  late CameraController _controller;
  late CameraDescription _mainCamera;
  late CameraDescription? _wideCamera;
  late CameraDescription _cameraDescription;

  bool _isUsingUltraWideCamera = false;

  double _currentZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  final double _maxZoomLevel = Platform.isAndroid ? 5.0 : 3.0;
  final double _zoomInFactor = 0.01;
  final double _zoomOutFactor = 0.03;
  late ResolutionPreset _resolution;

  late Future<void> _initializeControllerFuture;
  late AppDirectoryProvider _appDirectoryProvider;
  late UserAuthProvider _userAuthProvider;
  late VideoService _videoService;
  late ExerciseRecordModel _exerciseRecordModel;
  late ClimbingProblemService _climbingProblemService;
  late DifficultyService _difficultyService;

  ExerciseRecordWithJoin? _exerciseRecord;
  ClimbingProblem? _climbingProblem;
  Difficulty? _difficulty;
  List<Difficulty>? _difficulties;
  late Timer _timer;
  int _durationTime = 0;

  Uint8List? _thumbnailImage;

  @override
  void initState() {
    super.initState();

    _appDirectoryProvider = context.read<AppDirectoryProvider>();

    _videoService = context.read<VideoService>();
    _exerciseRecordModel = context.read<ExerciseRecordModel>();
    _climbingProblemService = context.read<ClimbingProblemService>();
    _difficultyService = context.read<DifficultyService>();
    _cameraProvider = context.read<CameraProvider>();
    _userAuthProvider = context.read<UserAuthProvider>();

    _resolution = _userAuthProvider.cameraResolution;

    if (_cameraProvider.mainCamera == null) {
      context.goNamed(ErrorPage.routerName);
      return;
    }
    _mainCamera = _cameraProvider.mainCamera!;
    _wideCamera = _cameraProvider.wideCamera;
    _cameraDescription = _mainCamera;
    _initializeControllerFuture = _setNewCameraController();

    WidgetsBinding.instance.addObserver(this);

    // Next, initialize the controller. This returns a Future.

    selectLocation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeControllerFuture = _controller.initialize();
    }
    if (state == AppLifecycleState.inactive) {
      if (_controller.value.isRecordingVideo) {
        _onPressedStopButton(0);
      }
    }
    if (state == AppLifecycleState.paused) {
      if (_controller.value.isRecordingVideo) {
        _onPressedStopButton(0);
      }
    }
  }

  Future<bool> _switchCamera(
      {CameraDescription? cameraDescription,
      ResolutionPreset? resolution}) async {
    if (_controller.value.isInitialized) {
      await _controller.dispose();
    }

    if (cameraDescription != null) {
      _cameraDescription = cameraDescription;
    }
    if (resolution != null) {
      _resolution = resolution;
    }

    await _setNewCameraController();
    return true;
  }

  // Future<void> _setZoomLevel(double currentZoomLevel) async {
  //   // 필요 시 초광각 카메라로 전환
  //   var result = false;
  //   if (_currentZoomLevel < 1.0 && !_isUsingUltraWideCamera) {
  //     _isUsingUltraWideCamera = true;
  //     result = await _switchCamera(widget.cameras[1]);
  //   } else if (_currentZoomLevel >= 1.0 && _isUsingUltraWideCamera) {
  //     _isUsingUltraWideCamera = false;
  //     result = await _switchCamera(widget.cameras[0]);
  //   }

  //   // 줌 범위에 맞게 값 제한
  //   currentZoomLevel = max(currentZoomLevel, _minZoomLevel);
  //   currentZoomLevel = min(currentZoomLevel, _maxZoomLevel);

  //   _controller.setZoomLevel(currentZoomLevel);
  //   setState(() {});
  // }

  Future<void> _setNewCameraController() async {
    _controller = CameraController(
      _cameraDescription,
      _resolution,
    );
    try {
      await _controller.initialize();
    } catch (e) {
      print(e);
    }
    await Future.wait(
      [
        _controller.prepareForVideoRecording(),
        Future.delayed(const Duration(milliseconds: 500)),
        _controller.getMinZoomLevel().then(
              (value) => _minZoomLevel = value,
            ),
      ],
    );
  }

  Future<void> selectLocation() async {
    try {
      _exerciseRecord =
          await _exerciseRecordModel.getUnFinishedExerciseRecord();
      if (!mounted) {
        return;
      }

      if (_exerciseRecord != null) {
        await loadCameraPageData(_exerciseRecord!);
        return;
      }

      var locationData = await showDialog<Map<String, Object>>(
        context: context,
        builder: (BuildContext context) => const LocationSearchDialog(),
      );
      if (!mounted) {
        return;
      }

      if (locationData == null) {
        context.goNamed(ExerciseRecordsPage.routerName);
        return;
      }

      var locationName = locationData["locationName"] as String;
      var locationId = locationData["locationId"] as int;
      await _exerciseRecordModel.createExerciseRecord(
          fileName:
              "${DateFormat('yyyy.MM.dd').format(DateTime.now())} $locationName",
          locationId: locationId);
      _exerciseRecord =
          await _exerciseRecordModel.getUnFinishedExerciseRecord();
      await loadCameraPageData(_exerciseRecord!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadCameraPageData(ExerciseRecordWithJoin exerciseRecord) async {
    _difficulties =
        await _difficultyService.getDifficulties(exerciseRecord.location.id);
    await loadClimbingProblem();
    if (_climbingProblem == null) {
      _difficulty = await _difficultyService
          .getLatestDifficultyByExerciseRecordWithJoin(exerciseRecord);
    } else {
      _difficulty =
          await _difficultyService.getDifficulty(_climbingProblem!.difficulty);
    }
    _videoService
        .getVideosByExerciseRecordId(
            exerciseRecordId: exerciseRecord.exerciseRecord.id)
        .then(
      (videoWithJoins) async {
        var videos =
            videoWithJoins.map((videoWithJoin) => videoWithJoin.video).toList();
        if (videos.isNotEmpty) {
          _thumbnailImage = (_appDirectoryProvider.getVideoThumbnail(
                  fileName: videos[0].fileName, videoId: videos[0].id))
              .readAsBytesSync();
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadClimbingProblem() async {
    var climbingProblem =
        await _climbingProblemService.getUnFinishedClimbingProblem();
    if (climbingProblem == null) {
      _climbingProblem = null;
    } else {
      _climbingProblem = climbingProblem;
    }
  }

  Future<void> _onPressedFinishExercise() async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const ConfirmationDialog(
        mainText: '오늘 운동을 다 하셨나요?',
        subText: '오늘 운동한 영상을 정리할까요?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (isConfirmed != null && isConfirmed) {
      if (_exerciseRecord != null) {
        if (_climbingProblem != null) {
          await _climbingProblemService.updateClimbingProblem(
            climbingProblem: _climbingProblem!,
            isFinished: true,
          );
        }
        await _exerciseRecordModel.updateExerciseRecord(
            exerciseRecordId: _exerciseRecord!.exerciseRecord.id,
            isFinished: true);
        if (mounted) {
          context.go(pathExerciseRecords);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: colorBlack,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: colorBlack,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          leading: IconButton(
            onPressed: () => context.goNamed(ExerciseRecordsPage.routerName),
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          titleSpacing: 0,
          title: _controller.value.isRecordingVideo
              ? Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorRed,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${(_durationTime ~/ 60).toString().padLeft(2, '0')}:${(_durationTime % 60).toString().padLeft(2, '0')}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              : Text(
                  _exerciseRecord != null
                      ? _exerciseRecord!.location.locationName
                      : '',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
          centerTitle: _controller.value.isRecordingVideo ? true : false,
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    colorLightGray.withOpacity(0.15)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () => _onPressedFinishExercise(),
              child: Text('운동 종료',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      )),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onScaleUpdate: (details) async {
                              if (details.focalPointDelta.distanceSquared
                                      .toDouble() <
                                  0.01) {
                                return;
                              }

                              if (details.scale < 1) {
                                _currentZoomLevel *=
                                    (1 + (details.scale - 1) * _zoomOutFactor);
                              } else {
                                _currentZoomLevel *=
                                    (1 + (details.scale - 1) * _zoomInFactor);
                              }

                              // 줌 범위에 맞게 값 제한
                              _currentZoomLevel =
                                  max(_currentZoomLevel, _minZoomLevel);
                              _currentZoomLevel =
                                  min(_currentZoomLevel, _maxZoomLevel);

                              await _controller.setZoomLevel(_currentZoomLevel);
                              setState(() {});
                            },
                            child: CameraPreview(_controller),
                          );
                        } else {
                          return _exerciseRecord != null
                              ? Align(
                                  alignment: const Alignment(0, -0.3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/location_thumbnails/${_exerciseRecord!.location.locationUid}.jpeg',
                                          width: 36,
                                          height: 36,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        _exerciseRecord!.location.locationName,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink();
                        }
                      },
                    ),
                    if (!_controller.value.isRecordingVideo)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(4),
                            Container(
                              decoration: BoxDecoration(
                                color: colorLightGray.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (_resolution ==
                                          ResolutionPreset.veryHigh) {
                                        return;
                                      }
                                      await _switchCamera(
                                        resolution: ResolutionPreset.veryHigh,
                                      );
                                      setState(() {});
                                      _userAuthProvider.updateResolution(
                                          ResolutionPreset.veryHigh);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _resolution ==
                                                ResolutionPreset.veryHigh
                                            ? colorBlack.withOpacity(0.5)
                                            : colorLightGray.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        '고화질',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: _resolution ==
                                                      ResolutionPreset.veryHigh
                                                  ? colorOrange
                                                  : colorGray,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const Gap(4),
                                  GestureDetector(
                                    onTap: () async {
                                      if (_resolution ==
                                          ResolutionPreset.high) {
                                        return;
                                      }
                                      await _switchCamera(
                                        resolution: ResolutionPreset.high,
                                      );
                                      setState(() {});
                                      _userAuthProvider.updateResolution(
                                          ResolutionPreset.high);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _resolution ==
                                                ResolutionPreset.high
                                            ? colorBlack.withOpacity(0.5)
                                            : colorLightGray.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        '기본',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: _resolution ==
                                                      ResolutionPreset.high
                                                  ? colorOrange
                                                  : colorGray,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (Platform.isIOS)
                              Container(
                                decoration: BoxDecoration(
                                  color: colorLightGray.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (_wideCamera == null &&
                                              _cameraDescription ==
                                                  _wideCamera) {
                                            return;
                                          }
                                          await _switchCamera(
                                            cameraDescription: _wideCamera,
                                          );
                                          _currentZoomLevel = 1.0;
                                          setState(() {
                                            _isUsingUltraWideCamera = true;
                                          });
                                        },
                                        child: ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: _isUsingUltraWideCamera
                                                ? 40
                                                : 28,
                                            height: _isUsingUltraWideCamera
                                                ? 40
                                                : 28,
                                            color: colorBlack.withOpacity(0.5),
                                            child: Text(
                                              '${_isUsingUltraWideCamera ? (_currentZoomLevel / 2).toStringAsFixed(1) : '0.5'}${_isUsingUltraWideCamera ? 'x' : ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          _isUsingUltraWideCamera
                                                              ? colorOrange
                                                              : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Gap(12),
                                      GestureDetector(
                                        onTap: () async {
                                          if (_cameraDescription ==
                                              _mainCamera) {
                                            return;
                                          }
                                          await _switchCamera(
                                            cameraDescription: _mainCamera,
                                          );
                                          _currentZoomLevel = 1.0;
                                          setState(() {
                                            _isUsingUltraWideCamera = false;
                                          });
                                        },
                                        child: ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: !_isUsingUltraWideCamera
                                                ? 40
                                                : 28,
                                            height: !_isUsingUltraWideCamera
                                                ? 40
                                                : 28,
                                            color: colorBlack.withOpacity(0.5),
                                            child: Text(
                                              '${!_isUsingUltraWideCamera ? _currentZoomLevel.toStringAsFixed(1) : '1.0'}${!_isUsingUltraWideCamera ? 'x' : ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          !_isUsingUltraWideCamera
                                                              ? colorOrange
                                                              : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (Platform.isAndroid)
                              Container(
                                decoration: BoxDecoration(
                                  color: colorLightGray.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          _currentZoomLevel = _minZoomLevel;
                                          await _controller
                                              .setZoomLevel(_currentZoomLevel);
                                          setState(() {});
                                        },
                                        child: ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width:
                                                _currentZoomLevel < 1 ? 40 : 28,
                                            height:
                                                _currentZoomLevel < 1 ? 40 : 28,
                                            color: colorBlack.withOpacity(0.5),
                                            child: Text(
                                              '${_currentZoomLevel < 1 ? _currentZoomLevel.toStringAsFixed(1) : '0.5'}${_currentZoomLevel < 1 ? 'x' : ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          _currentZoomLevel < 1
                                                              ? colorOrange
                                                              : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Gap(12),
                                      GestureDetector(
                                        onTap: () async {
                                          _currentZoomLevel = 1.0;
                                          await _controller
                                              .setZoomLevel(_currentZoomLevel);
                                          setState(() {});
                                        },
                                        child: ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: _currentZoomLevel >= 1
                                                ? 40
                                                : 28,
                                            height: _currentZoomLevel >= 1
                                                ? 40
                                                : 28,
                                            color: colorBlack.withOpacity(0.5),
                                            child: Text(
                                              '${_currentZoomLevel >= 1 ? _currentZoomLevel.toStringAsFixed(1) : '1.0'}${_currentZoomLevel >= 1 ? 'x' : ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          _currentZoomLevel >= 1
                                                              ? colorOrange
                                                              : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const Gap(12),
                            SizedBox(
                              height: 40,
                              child: _controller.value.isRecordingVideo
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(),
                                        SvgPicture.asset(
                                          'assets/icons/tape.svg',
                                          height: 24,
                                          colorFilter: ColorFilter.mode(
                                              _difficulty != null
                                                  ? Color(
                                                      _difficulty!.colorValue)
                                                  : Colors.white,
                                              BlendMode.srcIn),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _climbingProblem != null
                                              ? '시도 횟수 ${_climbingProblem!.trialCount}'
                                              : '시도 횟수 0',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            if (_climbingProblem == null)
                                              IconButton(
                                                onPressed: () =>
                                                    setDifficulty(-1),
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 20,
                                                  weight: 1500,
                                                ),
                                              ),
                                            SvgPicture.asset(
                                              'assets/icons/tape.svg',
                                              height: 24,
                                              colorFilter: ColorFilter.mode(
                                                  _difficulty != null
                                                      ? Color(_difficulty!
                                                          .colorValue)
                                                      : Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                            if (_climbingProblem == null)
                                              IconButton(
                                                onPressed: () =>
                                                    setDifficulty(1),
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  weight: 1500,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                            const Gap(
                              12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _controller.value.isRecordingVideo
                                    ? const SizedBox(
                                        width: 64,
                                        height: 64,
                                      )
                                    : Container(
                                        width: 64,
                                        height: 64,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color:
                                              colorLightGray.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_exerciseRecord != null) {
                                              context.pushNamed(
                                                  ExerciseRecordDetailPage
                                                      .routerName,
                                                  pathParameters: {
                                                    'exerciseRecordId':
                                                        _exerciseRecord!
                                                            .exerciseRecord.id
                                                            .toString(),
                                                  });
                                            }
                                          },
                                          child: _thumbnailImage != null
                                              ? Image.memory(
                                                  _thumbnailImage!,
                                                  width: 64,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Icon(
                                                  Icons.photo,
                                                  size: 64,
                                                  color: colorGray,
                                                ),
                                        ),
                                      ),
                                _controller.value.isRecordingVideo
                                    ? Container(
                                        width: 160,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              colorLightGray.withOpacity(0.15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _onPressedStopButton(1),
                                                child: Container(
                                                  width: 64,
                                                  height: 64,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: colorOrange,
                                                  ),
                                                  child: const Icon(
                                                    Icons.check,
                                                    color: colorBlack,
                                                    size: 56,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    _onPressedStopButton(0),
                                                child: Container(
                                                  width: 64,
                                                  height: 64,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: colorGray,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: colorBlack,
                                                    size: 56,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () =>
                                              startVideoRecording(),
                                          icon: const Icon(
                                            Icons.circle,
                                            size: 68,
                                            color: colorRed,
                                          ),
                                        ),
                                      ),
                                _controller.value.isRecordingVideo
                                    ? GestureDetector(
                                        onTap: () => _onPressedStopButton(2),
                                        child: Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: colorLightGray
                                                .withOpacity(0.15),
                                          ),
                                          child: const Icon(
                                            Icons.block,
                                            color: colorBlack,
                                            size: 56,
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          final isConfirmed =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const ConfirmationDialog(
                                              mainText: '다른 문제를 푸실건가요?',
                                              subText: '시도 횟수가 0으로 변경됩니다.',
                                              cancelText: '취소',
                                              confirmText: '포기',
                                            ),
                                          );
                                          if (isConfirmed ?? false) {
                                            await _finishClimbingProblem(
                                                false, false);
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: colorLightGray
                                                .withOpacity(0.15),
                                          ),
                                          child: Image.asset(
                                            'assets/images/give_up.png',
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 44,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setDifficulty(int result) {
    if (_difficulties != null && _difficulty != null) {
      var difficulties = _difficulties!;
      var difficulty = _difficulty!;

      var index = difficulties.indexOf(difficulty);
      if (index + result >= 0 && index + result < difficulties.length) {
        setState(() {
          _difficulty = difficulties[index + result];
        });
      }
    }
  }

  Future<String> saveVideo(XFile file, String fileName) async {
    // 파일 시스템에 비디오 저장
    var saveResult = await _appDirectoryProvider.saveVideoToAppDocDir(
      file,
      fileName,
    );
    return saveResult;
  }

  _finishClimbingProblem(bool isSuccess, bool addTrialCount) async {
    if (_climbingProblem == null) {
      Fluttertoast.showToast(msg: '문제를 먼저 시작해주세요.');
      return;
    }
    await _climbingProblemService.updateClimbingProblem(
      climbingProblem: _climbingProblem!,
      isSuccess: isSuccess,
      isFinished: true,
      addTrialCount: addTrialCount,
    );
    _climbingProblem = null;
  }

  /// recordResult 0: 실패, 1: 성공, 2: 취소
  _onPressedStopButton(int recordResult) async {
    if (!_controller.value.isRecordingVideo) {
      Fluttertoast.showToast(msg: 'not recording');
      return;
    }

    WakelockPlus.disable();
    if (recordResult == 2) {
      // 녹화 취소
      await _stopVideoRecording();
      return;
    }

    XFile xFile;
    try {
      xFile = await _stopVideoRecording();
    } catch (e) {
      return;
    }
    _timer.cancel();

    final thumbnailImage = await video_thumbnail.VideoThumbnail.thumbnailData(
      video: xFile.path,
      imageFormat: video_thumbnail.ImageFormat.JPEG,
      maxWidth:
          1080, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    if (thumbnailImage == null) {
      return;
    }

    // MB단위로 video data 크기를 저장.
    var videoDataSize =
        getMegaByteByByte(await xFile.length() + thumbnailImage.lengthInBytes);
    await _userAuthProvider.updateVideoCountAndTotalSize(videoDataSize);

    var fileName = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    var savedPath = await saveVideo(xFile, fileName);

    // 파일 삭제
    var file = File(xFile.path);
    await file.delete();

    if (_climbingProblem == null) {
      await _createClimbingProblem();
    }

    // 로컬 DB에 비디오 저장
    var videoId = await _videoService.createVideo(
      fileName: fileName,
      isSuccess: recordResult == 0 ? false : true,
      trialNumber: _climbingProblem!.trialCount + 1,
      climbingProblemId: _climbingProblem!.id,
      exerciseRecordId: _exerciseRecord!.exerciseRecord.id,
    );

    await _appDirectoryProvider.saveVideoThumbnailToAppDocDir(
      videoThumbnail: thumbnailImage,
      videoId: videoId,
      fileName: fileName,
    );
    _thumbnailImage = thumbnailImage;

    // 로컬 DB 문제 처리
    if (recordResult == 1) {
      await _finishClimbingProblem(true, true);
    } else {
      await _climbingProblemService.updateClimbingProblem(
        climbingProblem: _climbingProblem!,
        addTrialCount: true,
      );
      _climbingProblem = await _climbingProblemService
          .getClimbingProblem(_climbingProblem!.id);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> startVideoRecording() async {
    if (!_controller.value.isInitialized) {
      Fluttertoast.showToast(msg: 'Error: select a camera first.');
      return;
    }

    if (_controller.value.isRecordingVideo) {
      Fluttertoast.showToast(msg: 'already recording');
      // A recording is already started, do nothing.
      return;
    }

    if (_exerciseRecord == null) {
      Fluttertoast.showToast(msg: '암장을 설정하세요.');
      return;
    }

    if (_difficulty == null) {
      Fluttertoast.showToast(msg: '난이도를 설정하세요.');
      return;
    }

    try {
      // 비디오 시작 및 타이머 재생
      await _controller.startVideoRecording();
      await WakelockPlus.enable();

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _durationTime++;
          });
        }
      });
    } on CameraException catch (e) {
      _showCameraException(e);
      print(e);
      return;
    }
  }

  Future<XFile> _stopVideoRecording() async {
    try {
      var file = await _controller.stopVideoRecording();
      _durationTime = 0;

      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _createClimbingProblem() async {
    var climbingProblemId = await _climbingProblemService.createClimbingProblem(
        difficultyId: _difficulty!.id,
        exerciseRecordId: _exerciseRecord!.exerciseRecord.id);

    _climbingProblem =
        await _climbingProblemService.getClimbingProblem(climbingProblemId);
  }

  // error
  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    Fluttertoast.showToast(msg: 'Error: ${e.code}\n${e.description}');
  }

  void _logError(String code, String? message) {
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    WakelockPlus.disable();
    super.dispose();
  }
}
