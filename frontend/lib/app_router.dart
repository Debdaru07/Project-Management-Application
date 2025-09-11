import 'package:go_router/go_router.dart';

import 'pages/projects/add_project.dart';
import 'pages/projects/projects.dart';
import 'pages/task_details/task_details.dart';
import 'pages/tasks/tasks_page.dart';
import 'pages/tasks/upsert_task.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const ProjectsPage()),
      GoRoute(
        path: '/add-project',
        builder: (context, state) => const AddProjectPage(),
      ),
      GoRoute(
        path: '/tasks/:projectId',
        builder:
            (context, state) =>
                TasksPage(projectId: state.pathParameters['projectId']!),
      ),
      GoRoute(
        path: '/add-task/:projectId',
        builder:
            (context, state) =>
                AddTaskPage(projectId: state.pathParameters['projectId']!),
      ),
      // /task-details/${task.id}
      GoRoute(
        path: '/task-details/:taskId',
        builder:
            (context, state) =>
                TaskDetailsPage(taskId: state.pathParameters['taskId']!),
      ),
    ],
  );
}
