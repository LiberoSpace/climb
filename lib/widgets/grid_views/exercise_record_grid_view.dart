import 'package:climb/pages/camera_page.dart';
import 'package:climb/styles/app_colors.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/providers/app_directory_provider.dart';
import 'package:climb/widgets/exercise_record_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ExerciseRecordGridView extends StatefulWidget {
  final bool? isFixed;
  const ExerciseRecordGridView({
    super.key,
    this.isFixed,
  });

  @override
  State<ExerciseRecordGridView> createState() => _ExerciseRecordGridViewState();
}

class _ExerciseRecordGridViewState extends State<ExerciseRecordGridView> {
  late AppDirectoryProvider _appDirectoryProvider;
  late ExerciseRecordModel _exerciseRecordService;

  static const _pageSize = 20;
  final PagingController<int, ExerciseRecordWithJoin> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _appDirectoryProvider = context.read<AppDirectoryProvider>();
    _exerciseRecordService = context.read<ExerciseRecordModel>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _exerciseRecordService.getExerciseRecords(
          limit: _pageSize, offset: pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, ExerciseRecordWithJoin>(
      pagingController: _pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      shrinkWrap: widget.isFixed != null ? true : false,
      physics:
          widget.isFixed != null ? const NeverScrollableScrollPhysics() : null,
      builderDelegate: PagedChildBuilderDelegate<ExerciseRecordWithJoin>(
        itemBuilder: (context, item, index) => ExerciseRecordButton(
          appDirectoryProvider: _appDirectoryProvider,
          item: item,
          imageSize: 64,
        ),
        noItemsFoundIndicatorBuilder: (context) => Container(
          alignment: Alignment.center,
          color: colorLightGray,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    '저장된 운동 기록이 없어요.',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: colorGray),
                  ),
                  const Gap(8),
                  Text(
                    '아직 운동을 시작하지 않으셨나요?',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: colorGray),
                  )
                ],
              ),
              const Gap(16),
              TextButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: WidgetStateProperty.all<Color>(colorOrange),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                onPressed: () => context.pushNamed(CameraPage.routerName),
                child: Text('운동 영상을 찍으러 가보아요!',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
