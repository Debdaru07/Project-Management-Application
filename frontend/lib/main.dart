import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'model/project.dart';
import 'notifiers/project_notifier.dart';
import 'utils/theme/app_palette.dart' as palette;
import 'utils/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProjectNotifier()..addSampleData(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Project Management Tool',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme.copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: palette.AppPalette.resolutionBlue,
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}

extension ProjectNotifierExtension on ProjectNotifier {
  void addSampleData() {
    addProject(
      Project(
        id: '550e8400-e29b-41d4-a716-446655440000',
        title: 'Sample Project 1',
        description: 'A sample project description',
        status: 'in_progress',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    addProject(
      Project(
        id: 'a1b2c3d4-e5f6-4g7h-8i9j-0k1l2m3n4o5p',
        title: 'Sample Project 2',
        description: 'Another sample project',
        status: 'completed',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
