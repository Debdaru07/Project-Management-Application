import 'package:go_router/go_router.dart';

import 'pages/projects/projects.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const ProjectsPage()),
    ],
  );
}
