import 'dart:io';

import 'package:climb/styles/app_colors.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/styles/elevated_button_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationListView extends StatefulWidget {
  final String? word;
  final Function(String locationName, String locationUid, bool isRecentRecord)
      onPressedLocation;

  const LocationListView({
    super.key,
    required this.onPressedLocation,
    this.word,
  });

  @override
  State<LocationListView> createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  List<String> _locationNames = <String>[];
  List<String> _locationUids = <String>[];
  List<File> _locationThumbnailFiles = [];

  bool _isRecentRecord = true;
  late FirebaseFirestore firestore;
  final storageRef = FirebaseStorage.instance.ref();
  late AppDirectoryProvider _appDirectoryProvider;
  late ExerciseRecordModel _exerciseRecordModel;

  bool isPressed = true;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
    _exerciseRecordModel = context.read<ExerciseRecordModel>();

    getRecentLocations();
  }

  @override
  void didUpdateWidget(covariant LocationListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isRecentRecord = (widget.word == null || widget.word == "") ? true : false;

    if (_isRecentRecord) {
      getRecentLocations();
    } else {
      getLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _locationNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          onPressed: () => widget.onPressedLocation(
            _locationNames[index],
            _locationUids[index],
            _isRecentRecord,
          ),
          style: const ElevatedButtonStyle(
              normalColor: Colors.white, pressedColor: colorGray),
          child: Container(
            width: 300,
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _isRecentRecord
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.file(
                              _locationThumbnailFiles[index],
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            _locationNames[index],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.access_time,
                        color: colorGray,
                        size: 20,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        _locationNames[index],
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 4,
        child: Center(
          child: Container(
            height: 2,
            color: colorLightGray,
          ),
        ),
      ),
    );
  }

  void getRecentLocations() {
    _locationNames = <String>[];
    _locationUids = <String>[];
    _locationThumbnailFiles = [];

    // 최근 암장 방문 기록에서 암장 가져오기
    _exerciseRecordModel.getExerciseRecords().then((exerciseRecords) {
      if (exerciseRecords.isNotEmpty) {
        _isRecentRecord = true;
        for (var element in exerciseRecords) {
          if (!_locationUids.contains(element.location.locationUid)) {
            _locationNames.add(element.location.locationName);
            _locationUids.add(element.location.locationUid);
            _locationThumbnailFiles.add(_appDirectoryProvider
                .getLocationImageFile(element.location.locationUid));
            if (mounted) {
              setState(() {});
            }
          }
        }
      } else {
        _isRecentRecord = false;
        getLocations(isAll: true);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  void getLocations({bool isAll = false}) {
    _locationNames = <String>[];
    _locationUids = <String>[];
    _locationThumbnailFiles = [];

    // 검색을 통한 암장 가져오기
    var locationCollection = firestore.collection("locations");

    if (isAll) {
      locationCollection.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          _locationNames.add(docSnapshot.data()['name']);
          _locationUids.add(docSnapshot.id);
          if (mounted) {
            setState(() {});
          }
        }
      }, onError: (e) => print(e));
    } else {
      locationCollection
          .where('name', isGreaterThanOrEqualTo: widget.word!)
          .where('name', isLessThanOrEqualTo: '${widget.word!}\uf8ff')
          .get()
          .then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            _locationNames.add(docSnapshot.data()['name']);
            _locationUids.add(docSnapshot.id);
            if (mounted) {
              setState(() {});
            }
          }
        },
        onError: (e) => print(e),
      );
    }
  }
}
