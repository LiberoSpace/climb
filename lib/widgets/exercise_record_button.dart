import 'package:climb/pages/exercise_record_detail_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/constants/routes.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/styles/elevated_button_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseRecordButton extends StatelessWidget {
  final ExerciseRecordWithJoin item;
  final Color? normalColor;
  final Color? pressedColor;
  final double imageSize;

  const ExerciseRecordButton({
    super.key,
    required AppDirectoryProvider appDirectoryProvider,
    required this.item,
    required this.imageSize,
    this.normalColor,
    this.pressedColor,
  }) : _appDirectoryProvider = appDirectoryProvider;

  final AppDirectoryProvider _appDirectoryProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.pushNamed(
        ExerciseRecordDetailPage.routerName,
        pathParameters: {
          'exerciseRecordId': item.exerciseRecord.id.toString(),
        },
      ),
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: colorOrange,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.file(
              _appDirectoryProvider
                  .getLocationImageFile(item.location.locationUid),
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(4),
          Text(
            item.exerciseRecord.fileName.split(' ').sublist(1).join(' '),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            item.exerciseRecord.fileName.split(' ').first.substring(2),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
