import 'dart:collection';
import 'dart:io';

import 'package:climb/styles/app_colors.dart';
import 'package:climb/database/database.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/video_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/utils/get_file_size.dart';
import 'package:climb/widgets/bottom_tool_bar.dart';
import 'package:climb/widgets/buttons/app_bar_text_button.dart';
import 'package:climb/widgets/dialogs/confirmation_dialog.dart';
import 'package:climb/widgets/grid_views/video_thumbnails_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum SelectType { total, success, fail }

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
  List<Video> _videos = [];
  List<Video> _filteredVideos = [];
  HashSet<Video> _selectedVideos = HashSet<Video>();

  bool _isMultiSelectionEnabled = false;
  bool _isLoading = false;
  int _progressCount = 0;
  SelectType _selectType = SelectType.total;

  List<File> _thumbnails = [];
  List<File> _filteredThumbnails = [];

  late Stream<ExerciseRecordWithJoin> _exerciseRecordWithJoinStream;

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
    _videos = await _videoService.getVideosByExerciseRecordId(
        exerciseRecordId: _exerciseRecord!.id);
    _thumbnails = [];
    for (int i = 0; i < _videos.length; i++) {
      var thumbnail = _appDirectoryProvider.getVideoThumbnail(
          fileName: _videos[i].fileName, videoId: _videos[i].id);
      _thumbnails.add(thumbnail);
    }
    filterVideosBySelectType();
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                                    style: _selectType == SelectType.success
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                  ),
                                  selected: _selectType == SelectType.success,
                                  onSelected: (bool selected) {
                                    setState(
                                      () {
                                        _selectType = selected
                                            ? SelectType.success
                                            : SelectType.total;
                                      },
                                    );
                                    filterVideosBySelectType();
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
                                    style: _selectType == SelectType.fail
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                  ),
                                  selected: _selectType == SelectType.fail,
                                  onSelected: (bool selected) {
                                    setState(
                                      () {
                                        _selectType = selected
                                            ? SelectType.fail
                                            : SelectType.total;
                                      },
                                    );
                                    filterVideosBySelectType();
                                  },
                                ),
                              ],
                            ).toList(),
                          ),
                        ],
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
                Expanded(
                  child: _filteredVideos.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: VideoThumbnailsGridView(
                            exerciseRecordId: widget.exerciseRecordId,
                            videoWithThumbnails: List.generate(
                                _filteredThumbnails.length, (int idx) {
                              return VideoWithThumbnail(
                                  video: _filteredVideos[idx],
                                  thumbnail: _filteredThumbnails[idx]);
                            }),
                            isMultiSelectionEnabled: _isMultiSelectionEnabled,
                            activateMultiSelection: _activateMultiSelection,
                            selectVideo: _selectVideo,
                            isSelectedVideo: _isSelectedVideo,
                            loadVideos: _loadVideos,
                          ),
                        )
                      : const SizedBox(),
                ),
                BottomToolBar(
                  iconButtonDataList: [
                    BottomToolBarIconButtonData(
                      onPressed: _isMultiSelectionEnabled
                          ? _onPressedDownloadToGallery
                          : null,
                      icon: const Icon(Icons.file_download_outlined),
                    ),
                    BottomToolBarIconButtonData(
                      onPressed: _isMultiSelectionEnabled
                          ? () => _onPressedDeleteButton(context)
                          : null,
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

  filterVideosBySelectType() {
    _filteredVideos = [];
    _filteredThumbnails = [];
    if (_selectType == SelectType.total) {
      _filteredVideos = _videos;
      _filteredThumbnails = _thumbnails;
    } else if (_selectType == SelectType.success) {
      for (int i = 0; i < _videos.length; i++) {
        if (_videos[i].isSuccess) {
          _filteredVideos.add(_videos[i]);
          _filteredThumbnails.add(_thumbnails[i]);
        }
      }
    } else if (_selectType == SelectType.fail) {
      for (int i = 0; i < _videos.length; i++) {
        if (!_videos[i].isSuccess) {
          _filteredVideos.add(_videos[i]);
          _filteredThumbnails.add(_thumbnails[i]);
        }
      }
    }
    setState(() {});
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

  _onPressedDownloadToGallery() async {
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

  _onPressedDeleteButton(BuildContext context) async {
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
          mainText: '삭제 할까요?',
          subText:
              '삭제한 영상들은 영구적으로 삭제돼요.\n${formatBytesToMegaBytes(totalBytes)}가 삭제돼요.',
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
