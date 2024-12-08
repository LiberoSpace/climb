import 'dart:io';

import 'package:climb/styles/app_colors.dart';
import 'package:climb/database/database.dart';
import 'package:climb/database_services/difficulty_service.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/location_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/widgets/list_views/location_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationSearchDialog extends StatefulWidget {
  const LocationSearchDialog({
    super.key,
  });

  @override
  State<LocationSearchDialog> createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  final searchTextController = TextEditingController();

  late ExerciseRecordModel _exerciseRecordModel;
  late LocationService _locationService;
  late DifficultyService _difficultyService;
  late AppDirectoryProvider _appDirectoryProvider;
  late FirebaseFirestore firestore;

  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    _exerciseRecordModel = context.read<ExerciseRecordModel>();
    _locationService = context.read<LocationService>();
    _difficultyService = context.read<DifficultyService>();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 332,
        height: 364,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(
            color: colorOrange, // 원하는 색상으로 변경
            width: 6.0, // 테두리 두께
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "암장 선택",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: colorBlack,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  Container(
                    width: 300,
                    height: 44,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorLightGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          size: 28,
                          color: colorGray,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            controller: searchTextController,
                            cursorColor: colorSky,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: colorBlack,
                            ),
                            decoration: InputDecoration(
                              hintText: "운동할 암장을 선택해요.",
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: colorGray,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                searchTextController.text = "";
                              });
                            }
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: colorGray,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    color: colorOrange,
                    height: 2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: 300,
                    height: 236,
                    child: Column(
                      children: [
                        Expanded(
                          child: LocationListView(
                            onPressedLocation: _onPressedLocation,
                            word: searchTextController.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedLocation(
      String locationName, int locationId, bool isRecentRecord) async {
    try {
      var location = await _locationService.getLocation(locationId);
      if (mounted) {
        context.pop({
          "locationId": location.id,
          "locationName": location.locationName,
        });
        return;
      }
      // if (isRecentRecord) {
      //   if (mounted) {
      //     context.pop({
      //       "locationId": location.id,
      //       "locationName": location.locationName,
      //     });
      //     return;
      //   }
      // }

      // await _locationService.updateLocation(
      //     locationId: location.id, locationName: locationName);

      // await _locationThumbnailDownload(location);
      // await downloadDifficulties(locationUid, location.id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // _locationThumbnailDownload(Location location) async {
  //   try {
  //     final storageRef =
  //         this.storageRef.child("locations/${location.locationUid}.jpeg");
  //     final appDocDir = _appDirectoryProvider.appDocDir;
  //     final dirPath = "${appDocDir.path}/locations";
  //     final filePath = "$dirPath/${location.locationUid}.jpeg";
  //     final file = File(filePath);

  //     // 디렉터리가 없으면 생성
  //     final directory = Directory(dirPath);
  //     if (!directory.existsSync()) {
  //       await directory.create(recursive: true);
  //     }

  //     final downloadTask = storageRef.writeToFile(file);

  //     downloadTask.then(
  //       (value) {
  //         if (mounted) {
  //           context.pop({
  //             "locationId": location.id,
  //             "locationName": location.locationName,
  //           });
  //         }
  //       },
  //       onError: (e) => print(e),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // downloadDifficulties(String locationUid, int locationId) async {
  //   try {
  //     var difficultiesRef =
  //         firestore.collection("/locations/$locationUid/difficulties");

  //     var querySnapshot = await difficultiesRef.get();
  //     var dbDifficulties = await _difficultyService.getDifficulties(locationId);

  //     // drift DB에 없으면 추가
  //     for (var docSnapshot in querySnapshot.docs) {
  //       var isExist = false;
  //       for (var dbDifficulty in dbDifficulties) {
  //         if (dbDifficulty.uid == docSnapshot.id) {
  //           isExist = true;
  //           break;
  //         }
  //       }
  //       if (isExist) {
  //         continue;
  //       }
  //       await _difficultyService.createDifficulty(
  //           uid: docSnapshot.id,
  //           name: docSnapshot.data()['name'],
  //           colorValue:
  //               int.parse('0xFF${docSnapshot.data()['colorValueString']}'),
  //           score: docSnapshot.data()['score'],
  //           locationId: locationId);
  //     }

  //     for (var dbDifficulty in dbDifficulties) {
  //       // drift DB 난이도가 firestore 난이도에 존재하는지 확인
  //       var isActive = false;
  //       for (var docSnapshot in querySnapshot.docs) {
  //         if (dbDifficulty.uid == docSnapshot.id) {
  //           isActive = true;
  //           break;
  //         }
  //       }
  //       if (isActive) {
  //         continue;
  //       }
  //       await _difficultyService.updateDifficulty(
  //         difficultyId: dbDifficulty.id,
  //         isActive: isActive,
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
