import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/exercise_record_videos_detail_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/database/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VideoThumbnailsGridView extends StatefulWidget {
  final int exerciseRecordId;
  final List<VideoWithThumbnail> videoWithThumbnails;
  final bool isMultiSelectionEnabled;
  final Function() activateMultiSelection;
  final Function(Video video) selectVideo;
  final Function(Video video) isSelectedVideo;

  final Function() loadVideos;

  const VideoThumbnailsGridView({
    super.key,
    required this.exerciseRecordId,
    required this.videoWithThumbnails,
    required this.isMultiSelectionEnabled,
    required this.activateMultiSelection,
    required this.selectVideo,
    required this.isSelectedVideo,
    required this.loadVideos,
  });

  @override
  State<VideoThumbnailsGridView> createState() =>
      _VideoThumbnailsGridViewState();
}

class _VideoThumbnailsGridViewState extends State<VideoThumbnailsGridView> {
  // 썸네일 가져오기
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.videoWithThumbnails.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 9 / 16,
      ),
      itemBuilder: (context, int index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.isMultiSelectionEnabled) {
                  widget.selectVideo(widget.videoWithThumbnails[index].video);
                  return;
                }
                context.pushNamed(
                  ExerciseRecordVideosDetailPage.routerName,
                  pathParameters: {
                    'exerciseRecordId': widget.exerciseRecordId.toString(),
                  },
                  extra: {
                    "videoWithThumbnails": widget.videoWithThumbnails,
                    "initialIndex": index,
                  },
                ).then((value) => widget.loadVideos());
              },
              onLongPress: () {
                widget.selectVideo(widget.videoWithThumbnails[index].video);
                widget.activateMultiSelection();
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Image.file(
                      widget.videoWithThumbnails[index].thumbnail,
                      fit: BoxFit.cover,
                      color: widget.isSelectedVideo(
                              widget.videoWithThumbnails[index].video)
                          ? Colors.white.withOpacity(0.5)
                          : null,
                      colorBlendMode: widget.isSelectedVideo(
                              widget.videoWithThumbnails[index].video)
                          ? BlendMode.srcATop
                          : null,
                    ),
                    Visibility(
                      visible: widget.isSelectedVideo(
                          widget.videoWithThumbnails[index].video),
                      child: const Center(
                        child: Icon(Icons.check_circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.videoWithThumbnails[index].video.isLike)
              const Positioned(
                right: 8,
                bottom: 8,
                child: Icon(
                  // Icons.favorite_outline,
                  Icons.favorite,
                  color: colorRed,
                ),
              ),
          ],
        );
      },
    );
  }
}
