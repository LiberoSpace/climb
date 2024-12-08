import 'dart:io';

import 'package:climb/constants/config.dart';
import 'package:climb/pages/account_info_page.dart';
import 'package:climb/pages/announcements_page.dart';
import 'package:climb/pages/inquire_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/widgets/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  static String routerName = 'Settings';

  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<PackageInfo> packageInfoFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageInfoFuture = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          '설정',
        ),
      ),
      body: ListView(
        children: [
          const MiddleTitleBar(
            title: '안내',
          ),
          ContentTitleBar(
            onTapBar: () => context.pushNamed(AnnouncementsPage.routerName),
            title: '공지사항',
            tail: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
          ContentTitleBar(
            onTapBar: () => context.pushNamed(
              InquirePage.routerName,
            ),
            title: '문의하기',
            tail: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
          ContentTitleBar(
            title: '버전',
            tail: FutureBuilder(
              future: packageInfoFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var packageInfo = snapshot.data!;
                  return GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final appId = Platform.isAndroid
                            ? 'YOUR_ANDROID_PACKAGE_ID'
                            : 'YOUR_IOS_APP_ID';
                        final url = Uri.parse(
                          Platform.isAndroid
                              ? "market://details?id=$appId"
                              : "https://apps.apple.com/app/id$appId",
                        );
                        _launchUrl(
                          url,
                        );
                      }
                    },
                    child: Text(
                      packageInfo.version,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const TitleDivider(),
          const MiddleTitleBar(
            title: '사용자 설정',
          ),
          // ContentTitleBar(
          //   onTapBar: () => context.pushNamed(AccountInfoPage.routerName),
          //   title: '계정 정보',
          //   tail: const Icon(Icons.arrow_forward_ios_outlined),
          // ),
          const TitleDivider(),
          const MiddleTitleBar(
            title: '법적 고지',
          ),
          ContentTitleBar(
            onTapBar: () => _launchUrl(Uri.parse(
                'https://sites.google.com/view/climb-policy/terms-of-use')),
            title: '이용 약관',
          ),
          ContentTitleBar(
            onTapBar: () => _launchUrl(Uri.parse(
                'https://sites.google.com/view/climb-policy/privacy')),
            title: '개인정보 처리방침',
          ),
          ContentTitleBar(
            title: '오픈소스 라이선스',
            onTapBar: () {
              showLicensePage(
                  context: context,
                  applicationIcon: Image.asset('assets/logos/climb_logo.png'));
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class MiddleTitleBar extends StatelessWidget {
  final String title;

  const MiddleTitleBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class ContentTitleBar extends StatelessWidget {
  final Function()? onTapBar;
  final String title;
  final Widget? tail;

  const ContentTitleBar({
    super.key,
    required this.title,
    this.onTapBar,
    this.tail,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTapBar,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.fromLTRB(20, 0, 14, 0),
        ),
      ),
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (tail != null) tail!,
          ],
        ),
      ),
    );
  }
}
