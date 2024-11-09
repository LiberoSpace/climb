import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String uid;
  String title;
  String date;
  String description;

  AnnouncementModel({
    required this.uid,
    required this.title,
    required this.date,
    required this.description,
  });

  factory AnnouncementModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var date =
        '${snapshot.id.substring(0, 4)}.${snapshot.id.substring(4, 6)}.${snapshot.id.substring(6, 8)}';
    final data = snapshot.data();
    return AnnouncementModel(
      uid: snapshot.id,
      title: data?['title'],
      date: date,
      description: data?['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "description": description,
    };
  }
}
