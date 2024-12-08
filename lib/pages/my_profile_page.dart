// import 'dart:developer';

// import 'package:climb/database/database.dart';
// import 'package:climb/database_services/exercise_record_service.dart';
// import 'package:climb/database_services/video_service.dart';
// import 'package:climb/pages/my_profile_edit_page.dart';
// import 'package:climb/pages/settings_page.dart';
// import 'package:climb/pages/sign_up_second_page.dart';
// import 'package:climb/providers/app_directory_provider.dart';
// import 'package:climb/providers/user_auth_provider.dart';
// import 'package:climb/styles/app_colors.dart';
// import 'package:climb/utils/get_file_size.dart';
// import 'package:climb/widgets/grid_views/videos_sliver_grid_view.dart';
// import 'package:climb/widgets/grid_views/exercise_records_sliver_grid_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class MyProfilePage extends StatefulWidget {
//   static String routerName = 'MyProfile';

//   const MyProfilePage({super.key});

//   @override
//   State<MyProfilePage> createState() => _MyProfilePageState();
// }

// class _MyProfilePageState extends State<MyProfilePage>
//     with TickerProviderStateMixin {
//   final ScrollController _scrollController = ScrollController();
//   late VideoService _videoService;
//   late UserAuthProvider _userAuthProvider;
//   late AppDirectoryProvider _appDirectoryProvider;
//   late final TabController _tabController;

//   late Stream<List<Video>> _likedVideoStream;
//   List<VideoWithThumbnail> _likedVideoWithThumbnails = [];

//   late Stream<List<Video>> _remainVideosStream;
//   int _remainVideoCount = 0;
//   int? _remainVideoDataSize;

//   @override
//   void initState() {
//     super.initState();
//     _videoService = context.read<VideoService>();
//     _userAuthProvider = context.read<UserAuthProvider>();
//     _appDirectoryProvider = context.read<AppDirectoryProvider>();
//     _tabController = TabController(length: 2, vsync: this);

//     if (_userAuthProvider.appUser == null ||
//         _userAuthProvider.userProfile == null) {
//       log('no user');
//       _userAuthProvider.signOut(context);
//       return;
//     }

//     _remainVideosStream = _videoService.watchRemainVideos();
//     _remainVideosStream.listen((remainVideos) {
//       _remainVideoCount = remainVideos.length;
//       _remainVideoDataSize = _getRemainDataSize(remainVideos);
//     });

//     _likedVideoStream = _videoService.watchIsLikedVideos();
//     _likedVideoStream.listen((likedVideos) {
//       _likedVideoWithThumbnails = likedVideos.map((video) {
//         return VideoWithThumbnail(
//             video: video,
//             thumbnail: _appDirectoryProvider.getVideoThumbnail(
//                 fileName: video.fileName, videoId: video.id));
//       }).toList();
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   int _getRemainDataSize(List<Video> videos) {
//     var sum = 0;
//     for (var video in videos) {
//       sum += (_appDirectoryProvider.getVideoFile(video.fileName).lengthSync() +
//           _appDirectoryProvider
//               .getVideoThumbnail(fileName: video.fileName, videoId: video.id)
//               .lengthSync());
//     }
//     return getMegaByteByByte(sum);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userAuthProvider = context.watch<UserAuthProvider>();
//     final userProfile = userAuthProvider.userProfile!;
//     final appUser = userAuthProvider.appUser!;

//     var deleteVideoCount = userAuthProvider.totalVideoCount - _remainVideoCount;

//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 20,
//         title: Text(
//           _userAuthProvider.userProfile!.nickName,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         forceMaterialTransparency: true,
//         actions: [
//           IconButton(
//             onPressed: () => context.pushNamed(SettingsPage.routerName),
//             icon: const Icon(
//               Icons.settings_outlined,
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
//           child: NestedScrollView(
//             controller: _scrollController,
//             headerSliverBuilder: (context, innerBoxIsScrolled) => [
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ClipOval(
//                                       clipBehavior: Clip.hardEdge,
//                                       child: userProfile.profileImg != null
//                                           ? Image.memory(
//                                               userProfile.profileImg!,
//                                               width: 100,
//                                               height: 100,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.asset(
//                                               'assets/images/default_profile.png',
//                                               width: 100,
//                                               height: 100,
//                                               fit: BoxFit.cover,
//                                             ),
//                                     ),
//                                     const Gap(24),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               '난이도',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium,
//                                             ),
//                                             const Gap(16),
//                                             SvgPicture.asset(
//                                               'assets/icons/tape.svg',
//                                               width: 100,
//                                               height: 24,
//                                               colorFilter: ColorFilter.mode(
//                                                   profileDifficultyColors[
//                                                       userProfile
//                                                           .profileDifficultyIndex],
//                                                   BlendMode.srcIn),
//                                             ),
//                                           ],
//                                         ),
//                                         const Gap(16),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               '키 ${userProfile.height}',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium,
//                                             ),
//                                             const Gap(20),
//                                             const VerticalDivider(
//                                               width: 1,
//                                               color: colorLightGray,
//                                             ),
//                                             const Gap(20),
//                                             Text(
//                                               '암리치 ${userProfile.armReach ?? '--'}',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const Gap(8),
//                                 Row(
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         userProfile.profileIntroduction ?? '',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             const Gap(16),
//                             SizedBox(
//                               width: double.infinity,
//                               child: TextButton(
//                                 onPressed: () => context.pushNamed(
//                                   MyProfileEditPage.routerName,
//                                 ),
//                                 style: ButtonStyle(
//                                   shape: WidgetStatePropertyAll(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   backgroundColor: const WidgetStatePropertyAll(
//                                     colorLightGray,
//                                   ),
//                                   padding: const WidgetStatePropertyAll(
//                                     EdgeInsets.symmetric(
//                                       vertical: 8,
//                                     ),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   '프로필 수정',
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Gap(24),
//                         if (_remainVideoDataSize != null &&
//                             userAuthProvider.totalVideoCount != 0)
//                           remainDataBar(
//                             _remainVideoDataSize!,
//                             userAuthProvider.totalContentSizeMb,
//                             deleteVideoCount,
//                           ),
//                         const Gap(24),
//                       ],
//                     ),
//                     const Gap(12),
//                   ],
//                 ),
//               ),
//             ],
//             body: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TabBar(
//                   controller: _tabController,
//                   indicatorColor: colorOrange,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   tabs: const <Widget>[
//                     Tab(
//                       height: 48,
//                       child: Icon(
//                         Icons.favorite_outline,
//                         size: 24,
//                       ),
//                     ),
//                     Tab(
//                       height: 48,
//                       child: Icon(
//                         Icons.calendar_view_month_outlined,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Gap(12),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: <Widget>[
//                       _likedVideoWithThumbnails.isNotEmpty
//                           ? SizedBox(
//                               height: 300,
//                               child: VideosSliverGridView(
//                                 videoWithThumbnails: _likedVideoWithThumbnails,
//                               ),
//                             )
//                           : Container(
//                               color: colorLightGray,
//                               child: const Center(
//                                 child: Text('영상에 좋아요를 추가해보세요!'),
//                               ),
//                             ),
//                       Consumer<ExerciseRecordModel>(
//                           builder: (context, value, child) {
//                         var uk = UniqueKey();
//                         return ExerciseRecordsSliverGridView(
//                           key: uk,
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget remainDataBar(
//       int remainSize, int totalContentSizeMb, int deleteVideoCount) {
//     var totalSizeString = '${totalContentSizeMb}MB';
//     if (totalContentSizeMb >= 1024) {
//       totalSizeString = '${(totalContentSizeMb / 1024).toStringAsFixed(1)}GB';
//     }

//     var remainSizeString = '${remainSize}MB';
//     if (remainSize >= 1024) {
//       remainSizeString = '${(remainSize / 1024).toStringAsFixed(1)}GB';
//     }

//     var deletedSize = totalContentSizeMb - remainSize;
//     var deletedSizeString = '${deletedSize}MB';
//     if (deletedSize >= 1024) {
//       deletedSizeString = '${(deletedSize / 1024).toStringAsFixed(1)}GB';
//     }
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             deletedSize > 0
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         '$totalSizeString중 ',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                       Text(
//                         deletedSizeString,
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       Text(
//                         '를 절약했어요',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   )
//                 : Text(
//                     '$totalSizeString 저장 중 ',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//             const Gap(4),
//             Row(
//               children: [
//                 Expanded(
//                   flex: remainSize == deletedSize ? 1 : remainSize,
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 4,
//                     ),
//                     height: 20,
//                     decoration: const BoxDecoration(
//                       color: colorOrange,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         bottomLeft: Radius.circular(8),
//                       ),
//                     ),
//                     child: remainSize > 0
//                         ? Text(
//                             remainSizeString,
//                             style: Theme.of(context).textTheme.bodySmall,
//                           )
//                         : const SizedBox.shrink(),
//                   ),
//                 ),
//                 Expanded(
//                   flex: remainSize == deletedSize ? 1 : deletedSize,
//                   child: Container(
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 4,
//                     ),
//                     height: 20,
//                     decoration: BoxDecoration(
//                       color: deletedSize > 0 ? colorGray : colorOrange,
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(8),
//                         bottomRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: deletedSize > 0
//                         ? Text(
//                             deletedSizeString,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall!
//                                 .copyWith(color: colorWhite),
//                           )
//                         : const SizedBox.shrink(),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const Gap(4),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               '보관중인 영상 $_remainVideoCount개',
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//             Text(
//               '정리한 영상 $deleteVideoCount개',
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }
