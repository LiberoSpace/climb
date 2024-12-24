import 'package:climb/database/database.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/video_service.dart';
import 'package:climb/pages/settings_page.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/providers/user_auth_provider.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/utils/get_file_size.dart';
import 'package:climb/widgets/grid_views/exercise_record_grid_view.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseRecordsPage extends StatefulWidget {
  static String routerName = 'ExerciseRecords';

  const ExerciseRecordsPage({super.key});

  @override
  State<ExerciseRecordsPage> createState() => _ExerciseRecordsPageState();
}

class _ExerciseRecordsPageState extends State<ExerciseRecordsPage> {
  late VideoService _videoService;
  late AppDirectoryProvider _appDirectoryProvider;
  late UserAuthProvider _userAuthProvider;

  late Stream<List<Video>> _remainVideosStream;
  int _remainVideoCount = 0;
  int? _remainVideoDataSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoService = context.read<VideoService>();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
    _userAuthProvider = context.read<UserAuthProvider>();

    _remainVideosStream = _videoService.watchRemainVideos();
    _remainVideosStream.listen((remainVideos) {
      _remainVideoCount = remainVideos.length;
      _remainVideoDataSize = _getRemainDataSize(remainVideos);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _userAuthProvider = context.watch<UserAuthProvider>();

    var deleteVideoCount =
        _userAuthProvider.totalVideoCount - _remainVideoCount;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        titleSpacing: 20,
        title: Text(
          '운동 기록',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(SettingsPage.routerName),
            icon: const Icon(
              Icons.settings_outlined,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => DriftDbViewer(
          //           _videoService.db,
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Text('DB viewer'),
          // ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(12),
              if (_remainVideoDataSize != null &&
                  _userAuthProvider.totalVideoCount != 0)
                _remainDataBar(
                  _remainVideoDataSize!,
                  _userAuthProvider.totalContentSizeMb,
                  deleteVideoCount,
                ),
              if (_remainVideoDataSize != null &&
                  _userAuthProvider.totalVideoCount != 0)
                const Gap(32),
              Expanded(
                child: Consumer<ExerciseRecordModel>(
                  builder: (context, value, child) {
                    var uk = UniqueKey();
                    return ExerciseRecordGridView(
                      key: uk,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getRemainDataSize(List<Video> videos) {
    var sum = 0;
    for (var video in videos) {
      sum += (_appDirectoryProvider.getVideoFile(video.fileName).lengthSync() +
          _appDirectoryProvider
              .getVideoThumbnail(fileName: video.fileName, videoId: video.id)
              .lengthSync());
    }
    return getMegaByteByByte(sum);
  }

  Widget _remainDataBar(
      int remainSize, int totalContentSizeMb, int deleteVideoCount) {
    var totalSizeString = '${totalContentSizeMb}MB';
    if (totalContentSizeMb >= 1024) {
      totalSizeString = '${(totalContentSizeMb / 1024).toStringAsFixed(1)}GB';
    }

    var remainSizeString = '${remainSize}MB';
    if (remainSize >= 1024) {
      remainSizeString = '${(remainSize / 1024).toStringAsFixed(1)}GB';
    }

    var deletedSize = totalContentSizeMb - remainSize;
    var deletedSizeString = '${deletedSize}MB';
    if (deletedSize >= 1024) {
      deletedSizeString = '${(deletedSize / 1024).toStringAsFixed(1)}GB';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            deletedSize > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$totalSizeString중 ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        deletedSizeString,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '를 절약했어요',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                : Text(
                    '$totalSizeString 저장 중 ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
            const Gap(4),
            Row(
              children: [
                Expanded(
                  flex: remainSize == deletedSize ? 1 : remainSize,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    height: 20,
                    decoration: const BoxDecoration(
                      color: colorOrange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: remainSize > 0
                        ? Text(
                            remainSizeString,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Expanded(
                  flex: remainSize == deletedSize ? 1 : deletedSize,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    height: 20,
                    decoration: BoxDecoration(
                      color: deletedSize > 0 ? colorGray : colorOrange,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: deletedSize > 0
                        ? Text(
                            deletedSizeString,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: colorWhite),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '보관중인 영상 $_remainVideoCount개',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '정리한 영상 $deleteVideoCount개',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
