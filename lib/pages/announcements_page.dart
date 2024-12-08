import 'package:climb/models/announcement_model.dart';
import 'package:climb/pages/announcement_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnnouncementsPage extends StatefulWidget {
  static String routerName = 'Announcement';

  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<AnnouncementModel> _announcementModels = [];

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('announcements')
        .withConverter(
          fromFirestore: AnnouncementModel.fromFirestore,
          toFirestore: (AnnouncementModel announcement, _) =>
              announcement.toFirestore(),
        )
        .get()
        .then((snapshot) {
      _announcementModels = snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {});
    });
    super.initState();
  }

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
        children: [
          ...List<Widget>.generate(
            _announcementModels.isNotEmpty ? _announcementModels.length * 2 : 0,
            (index) => index % 2 == 0
                ? TextButton(
                    onPressed: () {
                      var announcementModel = _announcementModels[(index ~/ 2)];
                      context.pushNamed(AnnouncementDetailPage.routerName,
                          pathParameters: {
                            'announcementUid': announcementModel.uid,
                          },
                          extra: {
                            "announcement": announcementModel,
                          });
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _announcementModels[(index ~/ 2)].title,
                                softWrap: true,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                _announcementModels[(index ~/ 2)].date,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Divider(),
          ),
        ],
      )),
    );
  }
}
