import 'package:climb/styles/app_colors.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/styles/elevated_button_style.dart';
import 'package:climb/widgets/exercise_record_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExerciseRecordListView extends StatefulWidget {
  final List<ExerciseRecordWithJoin>? exerciseRecordWithJoin;
  const ExerciseRecordListView({super.key, this.exerciseRecordWithJoin});

  @override
  State<ExerciseRecordListView> createState() => _ExerciseRecordListViewState();
}

class _ExerciseRecordListViewState extends State<ExerciseRecordListView> {
  late AppDirectoryProvider _appDirectoryProvider;
  final List<Color> _colors = [
    colorOrange,
    colorLightGreen,
    colorSky,
    colorYellow,
  ];

  @override
  void initState() {
    super.initState();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.exerciseRecordWithJoin != null
          ? widget.exerciseRecordWithJoin!.length
          : 0,
      itemBuilder: (BuildContext context, int index) {
        return ExerciseRecordButton(
          appDirectoryProvider: _appDirectoryProvider,
          item: widget.exerciseRecordWithJoin![index],
          imageSize: 56,
          normalColor: _colors[index % 4],
          pressedColor: _colors[index % 4],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 12,
      ),
    );
  }
}
