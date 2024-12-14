import 'package:climb/database_services/exercise_record_service.dart';
import 'package:climb/pages/settings_page.dart';
import 'package:climb/widgets/grid_views/exercise_record_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseRecordsPage extends StatefulWidget {
  static String routerName = 'ExerciseRecords';

  const ExerciseRecordsPage({super.key});

  @override
  State<ExerciseRecordsPage> createState() => _ExerciseRecordsPageState();
}

class _ExerciseRecordsPageState extends State<ExerciseRecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        titleSpacing: 20,
        title: Text(
          '운동 기록',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(SettingsPage.routerName),
            icon: const Icon(
              Icons.settings_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Consumer<ExerciseRecordModel>(
                  builder: (context, value, child) {
                    var uk = UniqueKey();
                    return ExerciseRecordGridView(
                      key: uk,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
