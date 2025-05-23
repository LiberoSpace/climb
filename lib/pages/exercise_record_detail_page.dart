import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:climb/database/database.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/exercise_records_page.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/utils/get_file_size.dart';
import 'package:climb/widgets/bottom_tool_bar.dart';
import 'package:climb/widgets/buttons/app_bar_text_button.dart';
import 'package:climb/widgets/dialogs/confirmation_dialog.dart';
import 'package:climb/widgets/grid_views/video_thumbnails_grid_view.dart';
import 'package:climb/widgets/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExerciseRecordDetailPage extends StatefulWidget {
  static String routerName = 'ExerciseRecordDetail';

  final int exerciseRecordId;
  const ExerciseRecordDetailPage({super.key, required this.exerciseRecordId});

  @override
  State<ExerciseRecordDetailPage> createState() =>
      _ExerciseRecordDetailPageState();
}

class _ExerciseRecordDetailPageState extends State<ExerciseRecordDetailPage> {
  late ExerciseRecordModel _exerciseRecordModel;
  late VideoService _videoService;
  late AppDirectoryProvider _appDirectoryProvider;

  ExerciseRecord? _exerciseRecord;
  List<VideoWithJoin> _videoWithJoins = [];
  List<Video> _filteredVideos = [];
  HashSet<Video> _selectedVideos = HashSet<Video>();

  bool _isMultiSelectionEnabled = false;
  bool _isLoading = false;
  int _progressCount = 0;
  bool? _isSuccess;
  List<Difficulty> _difficulties = [];
  final List<Difficulty> _selectedDifficulties = [];

  List<File> _thumbnails = [];
  List<File> _filteredThumbnails = [];

  late Stream<ExerciseRecordWithJoin> _exerciseRecordWithJoinStream;
  late StreamSubscription _exerciseRecordWithJoinSubscription;

  _activateMultiSelection() {
    setState(() {
      _isMultiSelectionEnabled = true;
    });
  }

  _deactivateMultiSelection() {
    setState(() {
      _isMultiSelectionEnabled = false;
      _selectedVideos = HashSet<Video>();
    });
  }

  @override
  void initState() {
    super.initState();
    _exerciseRecordModel = context.read<ExerciseRecordModel>();
    _videoService = context.read<VideoService>();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();

    _exerciseRecordWithJoinStream = _exerciseRecordModel
        .watchExerciseRecordWithJoin(widget.exerciseRecordId);
    _exerciseRecordWithJoinSubscription =
        _exerciseRecordWithJoinStream.listen((exerciseRecordWithJoin) {
      _exerciseRecord = exerciseRecordWithJoin.exerciseRecord;
      _loadVideos();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadVideos() async {
    if (_exerciseRecord == null) {
      return;
    }
    _videoWithJoins = await _videoService.getVideosByExerciseRecordId(
        exerciseRecordId: _exerciseRecord!.id);
    _thumbnails = [];
    for (int i = 0; i < _videoWithJoins.length; i++) {
      var thumbnail = _appDirectoryProvider.getVideoThumbnail(
          fileName: _videoWithJoins[i].video.fileName,
          videoId: _videoWithJoins[i].video.id);
      _thumbnails.add(thumbnail);
    }

    // 난이도 얻기
    _difficulties = _videoWithJoins
        .map((videoWithJoin) => videoWithJoin.difficulty!)
        .toSet()
        .toList();

    _filterVideos();
    if (mounted) {
      setState(
        () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _exerciseRecord != null
            ? Text(
                _exerciseRecord!.fileName.substring(2),
              )
            : const SizedBox.shrink(),
        actions: [
          _isMultiSelectionEnabled
              ? AppBarTextButton(
                  onPressed: () => _deactivateMultiSelection(),
                  text: '취소',
                )
              : AppBarTextButton(
                  onPressed: () {
                    _activateMultiSelection();
                    _selectAllFilteredVideos();
                  },
                  text: '모두 선택',
                ),
          const Gap(8),
        ],
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 12,
                        children: List<Widget>.of(
                          [
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              selectedColor: colorOrange,
                              side: BorderSide.none,
                              label: Text(
                                '성공',
                                style: _isSuccess != null && _isSuccess!
                                    ? Theme.of(context).textTheme.titleMedium
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                              selected: _isSuccess != null && _isSuccess!,
                              onSelected: (bool selected) {
                                setState(
                                  () {
                                    _isSuccess = selected ? true : null;
                                  },
                                );
                                _filterVideos();
                              },
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              selectedColor: colorGray,
                              side: BorderSide.none,
                              label: Text(
                                '실패',
                                style: _isSuccess != null && !_isSuccess!
                                    ? Theme.of(context).textTheme.titleMedium
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                              selected: _isSuccess != null && !_isSuccess!,
                              onSelected: (bool selected) {
                                setState(
                                  () {
                                    _isSuccess = selected ? false : null;
                                  },
                                );
                                _filterVideos();
                              },
                            ),
                          ],
                        ).toList(),
                      ),
                      _isMultiSelectionEnabled
                          ? Text(
                              '${_selectedVideos.length}개 선택됨',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const Divider(
                  height: 4,
                  color: colorLightGrayE2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Wrap(
                    spacing: 12,
                    children: List<Widget>.generate(
                      _difficulties.length,
                      (idx) {
                        bool isSelected = _selectedDifficulties.contains(
                          _difficulties[idx],
                        );

                        return ChoiceChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          selectedColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          side: BorderSide.none,
                          label: Text(
                            _difficulties[idx].name,
                            style: isSelected
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.bodyMedium,
                          ),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            if (selected) {
                              _selectedDifficulties.add(_difficulties[idx]);
                            } else {
                              _selectedDifficulties.remove(_difficulties[idx]);
                            }

                            _filterVideos();
                          },
                        );
                      },
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: _filteredVideos.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: VideoThumbnailsGridView(
                            exerciseRecordId: widget.exerciseRecordId,
                            videoWithThumbnails: List.generate(
                              _filteredThumbnails.length,
                              (int idx) {
                                return VideoWithThumbnail(
                                  video: _filteredVideos[idx],
                                  thumbnail: _filteredThumbnails[idx],
                                );
                              },
                            ),
                            isMultiSelectionEnabled: _isMultiSelectionEnabled,
                            activateMultiSelection: _activateMultiSelection,
                            selectVideo: _selectVideo,
                            isSelectedVideo: _isSelectedVideo,
                            loadVideos: _loadVideos,
                          ),
                        )
                      : const SizedBox(),
                ),
                _isMultiSelectionEnabled
                    ? BottomToolBar(
                        iconButtonDataList: [
                          BottomToolBarIconButtonData(
                            onPressed: () =>
                                _onPressedDownloadToGallery(context),
                            icon: const Icon(Icons.file_download_outlined),
                          ),
                          BottomToolBarIconButtonData(
                            onPressed: () => _onPressedVideoDelete(context),
                            icon: const Icon(Icons.delete_outlined),
                          ),
                        ],
                      )
                    : BottomToolBar(
                        iconButtonDataList: [
                          BottomToolBarIconButtonData(
                            onPressed: () => _onPressedDeleteButton(context),
                            icon: const Icon(Icons.delete_outlined),
                          ),
                        ],
                      ),
              ],
            ),
            Visibility(
              visible: _isLoading,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: _progressCount.toDouble(),
                      strokeWidth: 6.0,
                      color: colorOrange,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$_progressCount개 완료',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _filterVideos() {
    _filteredVideos = [];
    _filteredThumbnails = [];
    for (int i = 0; i < _videoWithJoins.length; i++) {
      var successFilterResult = (_isSuccess == null) ||
          _videoWithJoins[i].video.isSuccess == _isSuccess;
      var difficultiesFilterResult = (_selectedDifficulties.isEmpty) ||
          _selectedDifficulties.contains(_videoWithJoins[i].difficulty);
      if (successFilterResult && difficultiesFilterResult) {
        _filteredVideos.add(_videoWithJoins[i].video);
        _filteredThumbnails.add(_thumbnails[i]);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  _selectAllFilteredVideos() {
    _selectedVideos = HashSet<Video>();
    setState(() {
      _selectedVideos.addAll(_filteredVideos);
    });
  }

  _selectVideo(Video video) {
    setState(() {
      if (_selectedVideos.contains(video)) {
        _selectedVideos.remove(video);
      } else {
        _selectedVideos.add(video);
      }
    });
  }

  bool _isSelectedVideo(Video video) {
    return _selectedVideos.contains(video);
  }

  _onPressedDeleteButton(BuildContext context) async {
    try {
      // 비디오 및 썸네일 파일 크기 계산
      var totalBytes = 0;
      List<VideoData> videosForDelete = [];
      for (var videoWithJoin in _videoWithJoins.toList()) {
        var video = videoWithJoin.video;
        var videoFile = _appDirectoryProvider.getVideoFile(
          video.fileName,
        );
        var thumbnailFile = _appDirectoryProvider.getVideoThumbnail(
          fileName: video.fileName,
          videoId: video.id,
        );
        videosForDelete.add(
          VideoData(
            video: video,
            videoFile: videoFile,
            videoThumbnail: thumbnailFile,
          ),
        );
        totalBytes += videoFile.lengthSync() + thumbnailFile.lengthSync();
      }
      if (!mounted) {
        return;
      }

      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => ConfirmationDialog(
          mainText: '운동 기록을 삭제할까요?',
          subText:
              '삭제하면 운동 기록과 영상들이 사라지고\n영상 용량 ${formatBytesToMegaBytes(totalBytes)}가 확보돼요.',
          cancelText: '취소',
          confirmText: '삭제',
        ),
      );
      if (isConfirmed ?? false) {
        setState(() {
          _isLoading = true;
          _progressCount = 0;
        });
        await Future.wait(videosForDelete.map((videoData) async {
          await Future.wait([
            videoData.videoFile.delete(),
            videoData.videoThumbnail.delete(),
            _videoService.deleteVideo(videoData.video.id),
          ]);
          setState(() {
            _progressCount++;
          });
        }));

        await _exerciseRecordWithJoinSubscription.cancel();
        await _exerciseRecordModel
            .deleteExerciseRecord(widget.exerciseRecordId);
        _isLoading = false;
        if (context.mounted) {
          context.goNamed(ExerciseRecordsPage.routerName);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  _onPressedDownloadToGallery(BuildContext context) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const ConfirmationDialog(
        mainText: '갤러리에 내보낼까요?',
        subText: '영상들은 내보낸 후에도 앱에 남아있습니다.',
        cancelText: '취소',
        confirmText: '내보내기',
      ),
    );
    if (isConfirmed ?? false) {
      setState(() {
        _isLoading = true;
        _progressCount = 0;
      });
      for (var video in _selectedVideos.toList()) {
        await _appDirectoryProvider.saveVideoToGallery(
          video,
        );
        setState(() {
          _progressCount++;
        });
      }
      _isLoading = false;
      _deactivateMultiSelection();
    }
  }

  _onPressedVideoDelete(BuildContext context) async {
    try {
      // 비디오 및 썸네일 파일 크기 계산
      var totalBytes = 0;
      List<VideoData> videosForDelete = [];
      for (var video in _selectedVideos.toList()) {
        var videoFile = _appDirectoryProvider.getVideoFile(
          video.fileName,
        );
        var thumbnailFile = _appDirectoryProvider.getVideoThumbnail(
          fileName: video.fileName,
          videoId: video.id,
        );
        videosForDelete.add(
          VideoData(
            video: video,
            videoFile: videoFile,
            videoThumbnail: thumbnailFile,
          ),
        );
        totalBytes += videoFile.lengthSync() + thumbnailFile.lengthSync();
      }
      if (!mounted) {
        return;
      }

      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => ConfirmationDialog(
          mainText: '선택한 영상들을 삭제할까요?',
          subText:
              '삭제한 영상들은 영구적으로 사라져요.\n영상 용량 ${formatBytesToMegaBytes(totalBytes)}가 확보돼요.',
          cancelText: '취소',
          confirmText: '삭제',
        ),
      );
      if (isConfirmed ?? false) {
        setState(() {
          _isLoading = true;
          _progressCount = 0;
        });
        await Future.wait(videosForDelete.map((videoData) async {
          await Future.wait([
            videoData.videoFile.delete(),
            videoData.videoThumbnail.delete(),
            _videoService.deleteVideo(videoData.video.id),
          ]);
          setState(() {
            _progressCount++;
          });
        }));

        if (_exerciseRecord == null) {
          Fluttertoast.showToast(msg: "please reload page");
          return;
        } else {
          await _loadVideos();
        }
        _isLoading = false;
        _deactivateMultiSelection();
      }
    } catch (e) {
      rethrow;
    }
  }
}

class VideoData {
  final Video video;
  final File videoFile;
  final File videoThumbnail;
  late final String dataSizeString;
  late final int dataSize;

  VideoData({
    required this.video,
    required this.videoFile,
    required this.videoThumbnail,
  }) {
    var totalDataSize = videoFile.lengthSync() + videoThumbnail.lengthSync();
    dataSizeString = formatBytesToMegaBytes(totalDataSize);
    dataSize = getMegaByteByByte(totalDataSize);
  }
}
