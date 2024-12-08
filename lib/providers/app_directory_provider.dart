import 'dart:io';

import 'package:camera/camera.dart';
import 'package:climb/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:mime/mime.dart';

class AppDirectoryProvider {
  final Directory appDocDir;
  late String docPath;
  late String videoPath;
  late String videoThumbnailPath;
  late Map<String, File> _fileMap;

  // final Directory appSupportDir;
  // final Directory appTempDir;

  AppDirectoryProvider({required this.appDocDir}) {
    docPath = appDocDir.path;
    videoPath = "$docPath/videos";
    videoThumbnailPath = "$docPath/videoThumbnails";
    createVideoFolder();
  }

  Future<void> createVideoFolder() async {
    var videoDir = Directory(videoPath);
    if (!videoDir.existsSync()) {
      await videoDir.create(recursive: true);
    }

    var videoThumbnailDir = Directory(videoThumbnailPath);
    if (!videoThumbnailDir.existsSync()) {
      await videoThumbnailDir.create(recursive: true);
    }
  }

  Future<String> saveVideoToAppDocDir(XFile video, String fileName) async {
    try {
      final videoFileName = '$fileName.mp4';

      // 디렉터리가 없으면 생성
      final directory = Directory(videoPath);
      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }

      // 4. 비디오 파일 복사하기
      await video.saveTo('$videoPath/$videoFileName');
      return '$videoPath/$videoFileName';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> saveVideoToGallery(Video video) async {
    try {
      final videoFileName = '${video.fileName}.mp4';
      await Gal.putVideo('$videoPath/$videoFileName');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  File getVideoThumbnail({required String fileName, required int videoId}) {
    try {
      final thumbnailFileName = '${videoId}_$fileName.jpeg';
      return File('$videoThumbnailPath/$thumbnailFileName');
    } catch (e) {
      if (e == PathNotFoundException) {
        throw PathNotFoundException;
      }
      print(e);
      rethrow;
    }
  }

  Future<String> saveVideoThumbnailToAppDocDir(
      {required Uint8List videoThumbnail,
      required String fileName,
      required int videoId}) async {
    try {
      final videoThumbnailFileName = '$fileName.jpeg';

      // 4. 비디오 파일 복사하기
      await File('$videoThumbnailPath/${videoId}_$videoThumbnailFileName')
          .writeAsBytes(videoThumbnail);
      return '$videoThumbnailPath/${videoId}_$videoThumbnailFileName';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  File getVideoFile(String fileName) {
    try {
      return File('$videoPath/$fileName.mp4');
    } catch (e) {
      if (e == PathNotFoundException) {
        throw PathNotFoundException;
      }
      print(e);
      rethrow;
    }
  }

  Future<Map<String, File>> loadFiles(
      List<String> fileNames, Directory dir) async {
    try {
      _fileMap = {};

      Stream<FileSystemEntity> fileEntities =
          dir.list(recursive: false, followLinks: false);

      await for (FileSystemEntity entity in fileEntities) {
        if (entity is File) {
          final fileName = entity.path.split(Platform.pathSeparator).last;
          if (fileNames.contains(fileName)) {
            _fileMap[fileName] = entity;
          }
        }
      }
      return _fileMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  // File getLocationImageFile(String locationUid) {
  //   try {
  //     return File("$docPath/locations/$locationUid.jpeg");
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // List<FileSystemEntity> getFilesInOrder() {
  //   return videoNames.map((name) => _fileMap[name]).toList();
  // }
}
