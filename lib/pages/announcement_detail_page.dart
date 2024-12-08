import 'package:climb/models/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailPage extends StatelessWidget {
  static String routerName = "AnnouncementDetail";
  final AnnouncementModel announcementModel;

  const AnnouncementDetailPage({super.key, required this.announcementModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          '공지사항',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcementModel.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(4),
                        Text(
                          announcementModel.date,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: MarkdownBody(
                data: announcementModel.description,
                softLineBreak: true,
                onTapLink: (text, url, title) {
                  print(announcementModel.description);
                  launchUrl(
                    Uri.parse(url!),
                  );
                },
                styleSheet: MarkdownStyleSheet(
                  a: Theme.of(context).textTheme.bodyMedium,
                  strong: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
