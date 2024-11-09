import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/videos_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VideosSliverGridView extends StatefulWidget {
  final List<VideoWithThumbnail> videoWithThumbnails;

  const VideosSliverGridView({
    super.key,
    required this.videoWithThumbnails,
  });

  @override
  State<VideosSliverGridView> createState() => _VideosSliverGridViewState();
}

class _VideosSliverGridViewState extends State<VideosSliverGridView> {
  // 썸네일 가져오기
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
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
                    context.pushNamed(
                      VideosDetailPage.routerName,
                      extra: {
                        "initialIndex": index,
                        "videoWithThumbnails": widget.videoWithThumbnails,
                      },
                    );
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
