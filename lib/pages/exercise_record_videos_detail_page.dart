import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/exercise_record_detail_page.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/utils/get_time.dart';
import 'package:climb/widgets/bottom_tool_bar.dart';
import 'package:climb/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ExerciseRecordVideosDetailPage extends StatefulWidget {
  static String routerName = 'ExerciseRecordVideosDetail';

  final int exerciseRecordId;
  final List<VideoWithThumbnail> videoWithThumbnails;
  final int initialIndex;
  const ExerciseRecordVideosDetailPage({
    super.key,
    required this.exerciseRecordId,
    required this.initialIndex,
    required this.videoWithThumbnails,
  });

  @override
  State<ExerciseRecordVideosDetailPage> createState() =>
      _VideoDetailPageState();
}

class _VideoDetailPageState extends State<ExerciseRecordVideosDetailPage> {
  late List<VideoPlayerController> _controllers;

  late VideoService _videoService;
  late AppDirectoryProvider _appDirectoryProvider;

  late PageController _pageController;
  bool _isFullScreen = false;
  bool _isLoading = true; // Future 작업 중일 때 true
  bool _isPlay = false;

  late VideoWithThumbnail _videoWithThumbnail;
  Size? _videoSize;
  Duration? _videoDuration;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _videoService = context.read<VideoService>();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
    _currentIndex = widget.initialIndex;

    _controllers = List.generate(
      widget.videoWithThumbnails.length,
      (index) => VideoPlayerController.file(
        _appDirectoryProvider
            .getVideoFile(widget.videoWithThumbnails[index].video.fileName),
      ),
    );

    _initVideoPlayerController();

    _videoWithThumbnail = widget.videoWithThumbnails[_currentIndex];
    _pageController = PageController(initialPage: _currentIndex);
  }

  // https://medium.com/@sanjeevmadhav03/preloading-videos-in-flutter-4b65cf0681c6

  _initVideoPlayerController() async {
    setState(() {
      _isLoading = true;
    });
    await _controllers[_currentIndex].initialize();
    _controllers[_currentIndex].addListener(_videoListener);
    _controllers[_currentIndex].play();
    setState(() {
      _isPlay = true;
    });
    _updatePage();
    if (_currentIndex + 1 < widget.videoWithThumbnails.length) {
      await _controllers[_currentIndex + 1].initialize();
    }
    if (_currentIndex - 1 >= 0) {
      await _controllers[_currentIndex - 1].initialize();
    }
    setState(() {
      _isLoading = false;
    });
  }

  _videoListener() {
    // 영상 재생 종료를 체크하는 코드
    if (_controllers[_currentIndex].value.position ==
        _controllers[_currentIndex].value.duration) {
      // 원하는 동작을 여기서 처리 가능 (예: 자동으로 다른 페이지로 이동)
      _controllers[_currentIndex].seekTo(const Duration(milliseconds: 0));
      setState(() {
        _isPlay = false;
      });
    }
  }

  _processVideoPlayerController(int index) async {
    setState(() {
      _isLoading = true;
    });
    var diff = index - _currentIndex;
    // 현재 영상 정지
    if (_controllers[_currentIndex].value.isPlaying) {
      await _controllers[_currentIndex].pause();
      _controllers[_currentIndex].seekTo(const Duration(milliseconds: 0));
      _controllers[_currentIndex].removeListener(_videoListener);
    }

    // 멀어진 리소스 정리
    var disposeIndex = index - 2 * diff;
    if (disposeIndex >= 0 && disposeIndex < _controllers.length) {
      await _controllers[disposeIndex].dispose();
      _controllers[disposeIndex] = VideoPlayerController.file(
        _appDirectoryProvider.getVideoFile(
            widget.videoWithThumbnails[disposeIndex].video.fileName),
      );
    }

    // 가까워진 리소스 초기화
    var initIndex = index + diff;
    if (initIndex >= 0 && initIndex < widget.videoWithThumbnails.length) {
      await _controllers[initIndex].initialize();
    }

    // 현재 비디오 재생
    _controllers[index].play();
    setState(() {
      _isLoading = false;
      _isPlay = true;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _onTapVideo,
                    child: PageView.builder(
                      onPageChanged: _onPageChanged,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: VideoPlayer(_controllers[index]),
                            ),
                            // Progress Bar 추가
                            Visibility(
                              visible: !_isFullScreen,
                              child: Positioned(
                                bottom:
                                    44, // Progress Bar를 BottomToolbar 위로 위치시킴
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 14,
                                  child: VideoProgressIndicator(
                                    _controllers[index],
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      playedColor: colorRed,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: _controllers.length,
                      physics: _isLoading
                          ? const NeverScrollableScrollPhysics() // 로딩 중일 때 스크롤 비활성화
                          : const AlwaysScrollableScrollPhysics(), // 로딩이 끝나면 스크롤 활성화,
                    ),
                  ),
                  Visibility(
                    visible: !_isFullScreen,
                    child: Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        leading: IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isFullScreen,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Builder(
                            builder: (context) {
                              return BottomToolBar(
                                iconButtonDataList: [
                                  BottomToolBarIconButtonData(
                                    onPressed: _likeVideo,
                                    icon: _videoWithThumbnail.video.isLike
                                        ? const Icon(Icons.favorite,
                                            color: colorRed)
                                        : const Icon(Icons.favorite_outline),
                                  ),
                                  BottomToolBarIconButtonData(
                                    onPressed: () {
                                      if (_controllers[_currentIndex]
                                          .value
                                          .isPlaying) {
                                        _controllers[_currentIndex]
                                            .pause()
                                            .then(
                                              (_) => setState(() {
                                                _isPlay = false;
                                              }),
                                            );
                                        return;
                                      }
                                      _controllers[_currentIndex].play().then(
                                            (_) => setState(() {
                                              _isPlay = true;
                                            }),
                                          );
                                    },
                                    icon: _isPlay
                                        ? const Icon(Icons.pause_circle_outline)
                                        : const Icon(Icons.play_circle_outline),
                                  ),
                                  BottomToolBarIconButtonData(
                                    onPressed: () => _showInfo(context),
                                    icon: const Icon(Icons.info_outline),
                                  ),
                                  BottomToolBarIconButtonData(
                                    onPressed: () => _delete(context),
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTapVideo() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  _updatePage() {
    _controllers[_currentIndex].addListener(_videoListener);
    _videoWithThumbnail = widget.videoWithThumbnails[_currentIndex];
    _updateVideoData(_controllers[_currentIndex].value.size,
        _controllers[_currentIndex].value.duration);
  }

  _onPageChanged(int index, {bool isDelete = false}) async {
    await _processVideoPlayerController(index);
    _currentIndex = index;
    _updatePage();
  }

  _updateVideoData(Size size, Duration duration) {
    _videoSize = size;
    _videoDuration = duration;
    setState(() {});
  }

  _likeVideo() async {
    var videoId = _videoWithThumbnail.video.id;
    var updatedVideoIndex = _currentIndex;
    await _videoService.updateVideo(
        video: _videoWithThumbnail.video,
        isLike: !_videoWithThumbnail.video.isLike);
    var video = await _videoService.getVideo(videoId);
    if (videoId == _videoWithThumbnail.video.id) {
      setState(() {
        _videoWithThumbnail.video = video;
      });
    }
    widget.videoWithThumbnails[updatedVideoIndex].video = video;
  }

  _showInfo(BuildContext context) async {
    var videoId = _videoWithThumbnail.video.id;
    var videoWithJoin =
        await _videoService.getVideoWithJoin(_videoWithThumbnail.video.id);
    if (!context.mounted ||
        videoId != _videoWithThumbnail.video.id ||
        _videoSize == null) {
      return;
    }
    VideoData videoData = VideoData(
      video: _videoWithThumbnail.video,
      videoFile: _appDirectoryProvider.getVideoFile(
        _videoWithThumbnail.video.fileName,
      ),
      videoThumbnail: _videoWithThumbnail.thumbnail,
    );

    await showModalBottomSheet(
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 349,
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getFullTime(_videoWithThumbnail.video.createdAt),
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Gap(4),
                        Flexible(
                          child: Text(
                            '${_videoWithThumbnail.video.fileName}.mp4',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '동영상 정보',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Wrap(
                          children: [
                            Text(
                              videoData.dataSizeString,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(width: 28),
                            Text(
                              '${_videoSize!.width.toInt()}X${_videoSize!.height.toInt()}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Text(
                              '${_videoDuration!.inSeconds ~/ 60}:${_videoDuration!.inSeconds % 60}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(width: 28),
                            Text(
                              videoWithJoin.video.isSuccess ? '성공' : '실패',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(width: 28),
                            Text(
                              videoWithJoin.difficulty!.name,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(width: 28),
                            Text(
                              videoWithJoin.location!.locationName,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _delete(BuildContext context) async {
    try {
      // 비디오 및 썸네일 파일 크기 계산
      VideoData videoData = VideoData(
        video: _videoWithThumbnail.video,
        videoFile: _appDirectoryProvider.getVideoFile(
          _videoWithThumbnail.video.fileName,
        ),
        videoThumbnail: _videoWithThumbnail.thumbnail,
      );

      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => ConfirmationDialog(
          mainText: '이 동영상을 삭제 할까요?',
          subText: '삭제한 영상은 영구적으로 삭제돼요.\n${videoData.dataSizeString}가 삭제돼요.',
          cancelText: '취소',
          confirmText: '삭제',
        ),
      );
      if (isConfirmed ?? false) {
        await Future.wait([
          videoData.videoFile.delete(),
          videoData.videoThumbnail.delete(),
        ]);
        await _videoService.deleteVideo(videoData.video.id);

        widget.videoWithThumbnails.removeAt(_currentIndex);
        var controller = _controllers[_currentIndex];
        _controllers.removeAt(_currentIndex);
        await controller.dispose();
        setState(() {
          _isLoading = true;
        });

        // 끝이었다면
        if (_currentIndex == _controllers.length) {
          _currentIndex -= 1;
          var initIndex = _currentIndex - 1;
          if (initIndex >= 0) {
            await _controllers[initIndex].initialize();
          }
          _controllers[_currentIndex].play();
        } else {
          var initIndex = _currentIndex + 1;
          if (initIndex < _controllers.length) {
            await _controllers[initIndex].initialize();
          }
          _controllers[_currentIndex].play();
        }

        setState(() {
          _isLoading = false;
          _isPlay = true;
        });
        _updatePage();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controllers[_currentIndex].dispose();
    if (_currentIndex - 1 >= 0) {
      _controllers[_currentIndex - 1].dispose();
    }
    if (_currentIndex + 1 < _controllers.length) {
      _controllers[_currentIndex + 1].dispose();
    }
    super.dispose();
  }
}
