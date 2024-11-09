import 'package:climb/pages/account_info_page.dart';
import 'package:climb/pages/announcement_detail_page.dart';
import 'package:climb/pages/announcements_page.dart';
import 'package:climb/pages/camera_page.dart';
import 'package:climb/pages/error_page.dart';
import 'package:climb/pages/exercise_record_detail_page.dart';
import 'package:climb/pages/exercise_record_videos_detail_page.dart';
import 'package:climb/pages/exercise_records_page.dart';
import 'package:climb/pages/inquire_page.dart';
import 'package:climb/pages/town_page.dart';
import 'package:climb/pages/my_profile_edit_page.dart';
import 'package:climb/pages/my_profile_page.dart';
import 'package:climb/pages/settings_page.dart';
import 'package:climb/pages/sign_up_page.dart';
import 'package:climb/pages/sign_up_second_page.dart';
import 'package:climb/pages/sing_in_page.dart';
import 'package:climb/pages/splash_page.dart';
import 'package:climb/pages/videos_detail_page.dart';
import 'package:climb/pages/videos_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomRouter {
  static GoRouter router = GoRouter(
    initialLocation: pathSplash,
    routes: [
      StatefulShellRoute.indexedStack(
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: pathExerciseRecords,
                name: ExerciseRecordsPage.routerName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                    child: ExerciseRecordsPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: pathMyProfile,
                name: MyProfilePage.routerName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                    child: MyProfilePage(),
                  );
                },
              ),
            ],
          ),
        ],
        builder: (context, state, navigationShell) => Scaffold(
          body: navigationShell,
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (navigationShell.currentIndex == 0) {
                          // 현재 페이지면 패스
                          return;
                        }
                        navigationShell.goBranch(0);
                      },
                      child: SizedBox(
                        child: Icon(Icons.photo_library_outlined,
                            size: 32,
                            color: navigationShell.currentIndex == 0
                                ? colorOrange
                                : null),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if (navigationShell.currentIndex == 1) {
                  //         // 현재 페이지면 패스
                  //         return;
                  //       }
                  //       navigationShell.goBranch(1);
                  //     },
                  //     child: SizedBox(
                  //       child: Icon(Icons.holiday_village_outlined,
                  //           size: 32,
                  //           color: navigationShell.currentIndex == 1
                  //               ? colorOrange
                  //               : null),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(CameraPage.routerName);
                      },
                      child: const SizedBox(
                        child: Icon(
                          Icons.camera_alt,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (navigationShell.currentIndex == 1) {
                          // 현재 페이지면 패스
                          return;
                        }

                        navigationShell.goBranch(1);
                      },
                      child: SizedBox(
                        child: Icon(Icons.person_outlined,
                            size: 32,
                            color: navigationShell.currentIndex == 1
                                ? colorOrange
                                : null),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if (navigationShell.currentIndex == 4) {
                  //         // 현재 페이지면 패스
                  //         return;
                  //       }
                  //       context.go(pathSettings);
                  //     },
                  //     child: SizedBox(
                  //       child: Icon(Icons.settings_outlined,
                  //           size: 32,
                  //           color: navigationShell.currentIndex == 4
                  //               ? colorOrange
                  //               : null),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      GoRoute(
        path: pathCamera,
        name: CameraPage.routerName,
        builder: (BuildContext context, GoRouterState state) {
          return const CameraPage();
        },
      ),
      GoRoute(
        path: '$pathExerciseRecords/:exerciseRecordId',
        name: ExerciseRecordDetailPage.routerName,
        builder: (BuildContext context, GoRouterState state) {
          var exerciseRecordIdString = state.pathParameters['exerciseRecordId'];
          if (exerciseRecordIdString != null) {
            return ExerciseRecordDetailPage(
              exerciseRecordId: int.parse(exerciseRecordIdString),
            );
          }
          return const ErrorPage();
        },
        routes: [
          GoRoute(
            path: '${pathVideos.substring(1)}$pathDetail',
            name: ExerciseRecordVideosDetailPage.routerName,
            builder: (BuildContext context, GoRouterState state) {
              var exerciseRecordIdString =
                  state.pathParameters['exerciseRecordId']!;
              return ExerciseRecordVideosDetailPage(
                exerciseRecordId: int.parse(exerciseRecordIdString),
                initialIndex:
                    (state.extra as Map<String, dynamic>)["initialIndex"],
                videoWithThumbnails: (state.extra
                    as Map<String, dynamic>)["videoWithThumbnails"],
              );
            },
          ),
        ],
      ),
      GoRoute(
          path: pathVideos,
          name: VideosPage.routerName,
          builder: (BuildContext context, GoRouterState state) {
            return const VideosPage();
          },
          routes: [
            GoRoute(
              path: pathDetail.substring(1),
              name: VideosDetailPage.routerName,
              builder: (BuildContext context, GoRouterState state) {
                return VideosDetailPage(
                  initialIndex:
                      (state.extra as Map<String, dynamic>)["initialIndex"],
                  videoWithThumbnails: (state.extra
                      as Map<String, dynamic>)["videoWithThumbnails"],
                );
              },
            ),
          ]),
      GoRoute(
        path: pathTown,
        name: TownPage.routerName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: TownPage());
        },
      ),
      GoRoute(
        path: pathSettings,
        name: SettingsPage.routerName,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPage();
        },
        routes: [
          GoRoute(
            path: 'account-info',
            name: AccountInfoPage.routerName,
            builder: (context, state) => const AccountInfoPage(),
          ),
          GoRoute(
            path: 'announcement',
            name: AnnouncementsPage.routerName,
            builder: (context, state) => const AnnouncementsPage(),
            routes: [
              GoRoute(
                path: ':announcementUid',
                name: AnnouncementDetailPage.routerName,
                builder: (context, state) => AnnouncementDetailPage(
                  announcementModel:
                      (state.extra as Map<String, dynamic>)["announcement"],
                ),
              )
            ],
          ),
          GoRoute(
            path: 'inquire',
            name: InquirePage.routerName,
            builder: (context, state) => const InquirePage(),
          )
        ],
      ),
      GoRoute(
        path: pathEdit,
        name: MyProfileEditPage.routerName,
        builder: (BuildContext context, GoRouterState state) {
          return const MyProfileEditPage();
        },
      ),
      GoRoute(
        path: pathSplash,
        name: SplashPage.routerName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: pathSignIn,
        name: SingInPage.routerName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: SingInPage());
        },
        routes: [
          GoRoute(
            path: pathSignUp.substring(1),
            name: SignUpPage.routerName,
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpPage();
            },
            routes: [
              GoRoute(
                path: pathSecond.substring(1),
                name: SignUpSecondPage.routerName,
                builder: (BuildContext context, GoRouterState state) {
                  try {
                    return SignUpSecondPage(
                      nickName:
                          (state.extra as Map<String, dynamic>)["nickName"],
                      birthDay:
                          (state.extra as Map<String, dynamic>)["birthDay"],
                      gender: (state.extra as Map<String, dynamic>)["gender"],
                      height: (state.extra as Map<String, dynamic>)["height"],
                    );
                  } catch (e) {
                    return const SignUpPage();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ],
    observers: [
      RouterObserver(),
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  );
}

const pathSignIn = '/sign-in';

const pathSignUp = '/sign-up';

const pathSecond = '/second';

const pathExerciseRecords = '/exercise-records';

const pathMyProfile = '/my-profile';

const pathSettings = '/settings';

const pathEdit = '/edit';

const pathTown = '/';

const pathSplash = '/splash';

const pathCamera = '/camera';

const pathVideos = '/videos';

const pathDetail = '/detail';

const pathLicense = '/license';

String getExerciseRecordVideoPath(int exerciseRecordId, int videoId) {
  return '/exercise-records/$exerciseRecordId/videos/$videoId';
}

String getExerciseRecordPath(int exerciseRecordId) {
  return '/exercise-records/$exerciseRecordId';
}

String getExerciseRecordDetailPath(int exerciseRecordId) {
  return '/exercise-records/$exerciseRecordId';
}

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}

String calculatePath(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return pathExerciseRecords;
    case 1:
      return pathTown;
    case 2:
      return pathCamera;
    case 3:
      return pathMyProfile;
    case 4:
      return pathSettings;
  }
  return pathExerciseRecords;
}
