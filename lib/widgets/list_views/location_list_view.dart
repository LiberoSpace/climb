import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/database_services/location_service.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/styles/elevated_button_style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationListView extends StatefulWidget {
  final String? word;
  final Function(String locationName, int locationUid, bool isRecentRecord)
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
  List<int> _locationIds = <int>[];
  List<String> _locationUids = <String>[];

  bool _isRecentRecord = false;
  final storageRef = FirebaseStorage.instance.ref();
  late ExerciseRecordModel _exerciseRecordModel;
  late LocationService _locationService;

  bool isPressed = true;

  @override
  void initState() {
    super.initState();
    _exerciseRecordModel = context.read<ExerciseRecordModel>();
    _locationService = context.read<LocationService>();

    getLocations(isAll: true).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
    // getRecentLocations().then((_) {
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
  }

  @override
  void didUpdateWidget(covariant LocationListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    getLocations().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    // _isRecentRecord = (widget.word == null || widget.word == "") ? true : false;

    // if (_isRecentRecord) {
    //   getRecentLocations().then((_) {
    //     if (mounted) {
    //       setState(() {});
    //     }
    //   });
    // } else {
    //   getLocations().then((_) {
    //     if (mounted) {
    //       setState(() {});
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _locationNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          onPressed: () => widget.onPressedLocation(
            _locationNames[index],
            _locationIds[index],
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
                            child: Image.asset(
                              'assets/location_thumbnails/${_locationUids[index]}.jpeg',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/location_thumbnails/${_locationUids[index]}.jpeg',
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

  Future<void> getRecentLocations() async {
    _locationNames = <String>[];
    _locationUids = <String>[];
    _locationIds = <int>[];

    // 최근 암장 방문 기록에서 암장 가져오기
    var exerciseRecords = await _exerciseRecordModel.getExerciseRecords();

    if (exerciseRecords.isNotEmpty) {
      _isRecentRecord = true;
      for (var element in exerciseRecords) {
        if (!_locationIds.contains(element.location.id)) {
          _locationNames.add(element.location.locationName);
          _locationIds.add(element.location.id);
          _locationUids.add(element.location.locationUid);
          if (mounted) {
            setState(() {});
          }
        }
      }
    } else {
      _isRecentRecord = false;
      await getLocations(isAll: true);
    }
  }

  Future<void> getLocations({bool isAll = false}) async {
    _locationNames = <String>[];
    _locationUids = <String>[];
    _locationIds = <int>[];

    var locations = await _locationService.getLocations(search: widget.word);

    // if (isAll) {
    //   locationCollection.get().then((querySnapshot) {
    //     for (var docSnapshot in querySnapshot.docs) {
    //       _locationNames.add(docSnapshot.data()['name']);
    //       _locationIds.add(docSnapshot.id);
    //       if (mounted) {
    //         setState(() {});
    //       }
    //     }
    //   }, onError: (e) => print(e));
    // } else {
    //   locationCollection
    //       .where('name', isGreaterThanOrEqualTo: widget.word!)
    //       .where('name', isLessThanOrEqualTo: '${widget.word!}\uf8ff')
    //       .get()
    //       .then(
    //     (querySnapshot) {
    //       for (var docSnapshot in querySnapshot.docs) {
    //         _locationNames.add(docSnapshot.data()['name']);
    //         _locationIds.add(docSnapshot.id);
    //         if (mounted) {
    //           setState(() {});
    //         }
    //       }
    //     },
    //     onError: (e) => print(e),
    //   );
    // }
    for (var location in locations) {
      _locationNames.add(location.locationName);
      _locationIds.add(location.id);
      _locationUids.add(location.locationUid);
    }
  }
}
