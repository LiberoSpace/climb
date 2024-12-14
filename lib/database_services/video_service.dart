import 'dart:io';

import 'package:climb/database/database.dart';
import 'package:drift/drift.dart';

class VideoWithThumbnail {
  Video video;
  File thumbnail;
  VideoWithThumbnail({required this.video, required this.thumbnail});
}

class VideoWithJoin {
  final Video video;
  ClimbingProblem? climbingProblem;
  ExerciseRecord? exerciseRecord;
  Location? location;
  Difficulty? difficulty;
  VideoWithJoin({
    required this.video,
    this.exerciseRecord,
    this.climbingProblem,
    this.location,
    this.difficulty,
  });
}

class VideoService {
  final AppDatabase db;

  VideoService({required this.db});

  // video CRUD
  Future<Video> getVideo(int videoId) async {
    try {
      var query = db.select(db.videos)
        ..where(
          (tbl) => tbl.id.equals(videoId),
        );

      return await query.getSingle();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Video>> getVideos({bool? isLike}) async {
    try {
      var query = db.select(db.videos);
      if (isLike != null) {
        query.where(
          (tbl) => tbl.isLike.equals(isLike),
        );
      }

      return await query.get();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<VideoWithJoin> getVideoWithJoin(int videoId) async {
    try {
      var query = db.select(db.videos).join(
        [
          innerJoin(
            db.climbingProblems,
            db.climbingProblems.id.equalsExp(db.videos.climbingProblem),
          ),
          innerJoin(
            db.exerciseRecords,
            db.exerciseRecords.id.equalsExp(db.climbingProblems.exerciseRecord),
          ),
          innerJoin(
            db.difficulties,
            db.difficulties.id.equalsExp(db.climbingProblems.difficulty),
          ),
          innerJoin(
            db.locations,
            db.locations.id.equalsExp(db.exerciseRecords.location),
          ),
        ],
      )..where(
          db.videos.id.equals(videoId),
        );

      var row = await query.getSingle();
      return VideoWithJoin(
        video: row.readTable(db.videos),
        climbingProblem: row.readTable(db.climbingProblems),
        exerciseRecord: row.readTable(db.exerciseRecords),
        location: row.readTable(db.locations),
        difficulty: row.readTable(db.difficulties),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<VideoWithJoin>> getVideosByExerciseRecordId(
      {required int exerciseRecordId}) async {
    try {
      var query = db.select(db.videos).join(
        [
          innerJoin(
            db.climbingProblems,
            db.climbingProblems.id.equalsExp(db.videos.climbingProblem),
          ),
          innerJoin(
            db.difficulties,
            db.difficulties.id.equalsExp(db.climbingProblems.difficulty),
          ),
          innerJoin(
            db.exerciseRecords,
            db.exerciseRecords.id.equalsExp(db.climbingProblems.exerciseRecord),
          ),
        ],
      )..where(
          db.exerciseRecords.id.equals(exerciseRecordId),
        );

      query = (query
        ..orderBy(
          [
            // 최신순 정렬. 예상 파일 명 2024.06.02_더클라임 연남
            OrderingTerm(
              expression: db.videos.createdAt,
              mode: OrderingMode.desc,
            )
          ],
        ));

      var rows = await query.get();
      return rows
          .map(
            (row) => VideoWithJoin(
              video: row.readTable(db.videos),
              climbingProblem: row.readTable(db.climbingProblems),
              exerciseRecord: row.readTable(db.exerciseRecords),
              difficulty: row.readTable(db.difficulties),
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> createVideo({
    required String fileName,
    required bool isSuccess,
    required int trialNumber,
    required int climbingProblemId,
    required int exerciseRecordId,
  }) async {
    try {
      return await db.into(db.videos).insert(
            VideosCompanion.insert(
              fileName: fileName,
              isSuccess: Value(isSuccess),
              trialNumber: trialNumber,
              climbingProblem: climbingProblemId,
              exerciseRecord: exerciseRecordId,
            ),
          );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> updateVideo({
    required Video video,
    String? fileName,
    bool? isLike,
    bool? isSuccess,
  }) async {
    try {
      return db.transaction(() async {
        var rowCount = await (db.update(db.videos)
              ..where(
                (tbl) => tbl.id.equals(video.id),
              ))
            .write(
          VideosCompanion(
            fileName: fileName != null ? Value(fileName) : const Value.absent(),
            isLike: isLike != null ? Value(isLike) : const Value.absent(),
            isSuccess:
                isSuccess != null ? Value(isSuccess) : const Value.absent(),
          ),
        );
        // 성공 비디오가 수집될 때, 해당 문제도 성공으로 변경
        if (isSuccess == true) {
          await (db.update(db.climbingProblems)
                ..where(
                  (tbl) => tbl.id.equals(video.climbingProblem),
                ))
              .write(
            const ClimbingProblemsCompanion(
              isSuccess: Value(true),
            ),
          );
        }
        return rowCount;
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteVideo(int videoId) async {
    try {
      await (db.delete(db.videos)..where((t) => t.id.equals(videoId))).go();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Video>> watchIsLikedVideos() {
    try {
      return (db.select(db.videos)..where((t) => t.isLike.equals(true)))
          .watch();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Video>> watchRemainVideos() {
    try {
      return db.select(db.videos).watch();
    } catch (e) {
      rethrow;
    }
  }
}
